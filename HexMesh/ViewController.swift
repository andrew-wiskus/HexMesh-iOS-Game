//
//  ViewController.swift
//  HexMesh
//
//  Created by Andrew Wiskus on 1/15/17.
//  Copyright © 2017 Andrew Wiskus. All rights reserved.
//

import UIKit
struct XY{
    var x = 0
    var y = 0
}
class ViewController: UIViewController {

    //TODO
    //1. have image for current position

    //3. put timer on top under level
    //4. have a checkWin() in tap
    //5. have a winScreen
    //6. get level screen to show levels
    //7. have left/right arrows for level nav while in-game
    //8. make 10 levels!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gameMap = level1
        view.backgroundColor = .black
        buildGameBoard()

        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    func buildGameBoard(){
        for container in view.subviews {
            if(container.tag == 99){
                //set gameboard view property
                container.backgroundColor = .black
                
                //set button properties
                for button in container.subviews {
                    let xy = getXYfromTag(tag: button.tag)
                    let score = gameMap[xy.y - 1][xy.x - 1]
                    let theButton = button as! UIButton
                    let buttonImage = setButtonImage(position: xy)
                    theButton.setBackgroundImage(buttonImage, for: .normal)
                    theButton.backgroundColor = .clear
                    theButton.setTitle(score > 0 ? String(score) : "", for: .normal)
                }
                
            }
        }
    }
    
    func initGame(){
        gameMap = level1
        currentPosition = XY(x: 0, y:0)
        buildGameBoard()
    }

    
@IBAction func tappedRestartButton(_ sender: Any) {
        initGame()
    }
    
@IBAction func tappedGamePeice(_ sender: UIButton) {
        let buttonPosition = getXYfromTag(tag: sender.tag)

    
        if(checkLogic(position: buttonPosition)){
            print("good tap! go again")
            currentPosition = buttonPosition
            gameMap[currentPosition.y-1][currentPosition.x-1] = gameMap[currentPosition.y-1][currentPosition.x-1] - 1
            let score = gameMap[currentPosition.y-1][currentPosition.x-1]
            let btnImage = setButtonImage(position: buttonPosition)
            sender.setTitle(score > 0 ? String(score) : "", for: .normal)
            sender.setBackgroundImage(btnImage, for: .normal)
        }
    }
    
    var currentPosition = XY(x: 0, y: 0)
    func checkLogic(position: XY) -> BooleanLiteralType{
        
        let currentX = currentPosition.x
        let currentY = currentPosition.y
        let nextX = position.x
        let nextY = position.y
        
        if(gameMap[nextY - 1][nextX - 1] == 0){
            print("you cant click on nothing")
            return false
        }
        //first tap
        if currentX == 0 && currentY == 0 {
            return true
        }
        
        //if tapped on same row
        if currentY == nextY && (currentX == nextX + 1 || currentX == nextX - 1) {
            
            return true
        }
        
        //check even/odd row
        if(currentY % 2 != 0){
            //tapped up
            if currentY == nextY - 1 && (currentX == nextX || currentX == nextX - 1) {
                
                return true
                
            }
            //tapped down
            if currentY == nextY + 1 && (currentX == nextX || currentX == nextX - 1) {
                
                return true
            }
        } else {
            //tapped up
            if currentY == nextY - 1 && (currentX == nextX || currentX == nextX + 1) {
                
                return true
                
            }
            //tapped down
            if currentY == nextY + 1 && (currentX == nextX || currentX == nextX + 1) {
                
                return true
            }
        }
        
        //bad press, do nothin
        return false
    }
    
    func getXYfromTag(tag: Int) -> XY{
        let x = (tag % 10)
        let y = (tag - x) / 10
        return XY(x: x, y: y)
    }
    
    func setButtonImage(position: XY) -> UIImage? {
        let x = position.x - 1
        let y = position.y - 1
        
        if(gameMap[y][x] != 0){
            let imageString = "hex\(gameMap[y][x])"
            
            return UIImage(named: imageString)!
        } else {
            
            return nil
        }
    }

  
    //MARK: LEVEL DESIGN
    var gameMap = [[0]]
    var levels = [[[0]]]
    
    let level1 = [
        [1,1,1,3],
        [3,4,5,2,1],
        [1,2,0,0],
        [1,2,3,2,1],
        [3,0,5,1],
        [0,1,3,2,1],
        [1,1,0,1]
    ]
    let level2 = [
        [2,2,3,2],
        [1,2,3,2,1],
        [1,1,1,1],
        [1,2,3,2,1],
        [1,1,1,1],
        [1,2,3,2,1],
        [1,2,2,2]
    ]
    let level3 = [
        [1,1,3,1],
        [1,2,3,2,1],
        [1,2,2,1],
        [1,2,3,1,1],
        [1,2,3,2],
        [1,2,3,2,1],
        [1,1,1,1]
    ]

}

