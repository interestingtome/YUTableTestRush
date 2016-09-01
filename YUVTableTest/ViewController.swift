//
//  ViewController.swift
//  YUVTableTest
//
//  Created by Tai on 8/31/16.
//  Copyright © 2016 PolyEngine. All rights reserved.
//

import UIKit
import YUTableView_Swift


class ViewController: UIViewController,YUTableViewDelegate {
    
    @IBOutlet weak var mytable: YUTableView!
    
    //Full list
    var tableData : [YUTableViewNode]!
    //Sub list showing checked items only
    var tableData2: [YUTableViewNode]!
    
    var bathing = ["Bed Bath","Sponge Bath","Tub Bath","Shower"]
    var Personal_Care = ["Peri-Care","Shampoo","Care/Shampoo","Skin","Oral Hygiene","Shave","Dress"]
    var nutrition = ["Special Diet","Meal","Client"]
    var elimination = ["Assist to Bathroom","Assist to Bedside Commode","Bed Pan","Disposable Diapers"]
    var activity = ["ROM Excercises","Bedrest turn & position every 2 hours","Walk with","Walk with device"]
    var add_assign = ["Clean Kitchen","Purchase food","Clean bathroom","Laundry","Vacuum/Dust","Transport Client","Medication reminder","Companion care"]
    
    var reviewstate = false
    
    @IBAction func commitClicked(sender: AnyObject) {
        if(tableData2?.count < 1){
            return
        }
        reviewstate = true
        mytable.setNodes(tableData2)
        mytable.reloadData()
    }
    
    @IBAction func cancelClicked(sender: AnyObject) {
        
        reviewstate = false
        mytable.setNodes(tableData)
        mytable.reloadData()
    }
    

    
    func createNodes () -> [YUTableViewNode] {
        var tempmain = ["label":"Bathing","clicked":false,"oldlabel":"Bathing"]
        var bathing_node = [YUTableViewNode]()
        for items in bathing {
            let temp = ["label":items,"clicked":false]
            let node = YUTableViewNode(data: temp as? AnyObject, cellIdentifier: "subcell")
            bathing_node.append(node)
        }
        let bath = YUTableViewNode(childNodes: bathing_node, data: tempmain as AnyObject, cellIdentifier: "Cell")
        
        var pc_node = [YUTableViewNode]()
        for items in Personal_Care {
            let temp = ["label":items,"clicked":false]
            let node = YUTableViewNode(data: temp as AnyObject, cellIdentifier: "subcell")
            pc_node.append(node)
        }
        tempmain = ["label":"Personal Care","clicked":false,"oldlabel":"Personal Care"]
        let pc = YUTableViewNode(childNodes: pc_node, data: tempmain as AnyObject, cellIdentifier: "Cell")
        
        var nutrition_node = [YUTableViewNode]()
        for items in nutrition {
            let temp = ["label":items,"clicked":false]
            let node = YUTableViewNode(data: temp as AnyObject, cellIdentifier: "subcell")
            nutrition_node.append(node)
        }
        tempmain = ["label":"Nutrition","clicked":false,"oldlabel":"Nutrition"]
        let nutri = YUTableViewNode(childNodes: nutrition_node, data: tempmain as AnyObject, cellIdentifier: "Cell")
        
        var elimination_node = [YUTableViewNode]()
        for items in elimination {
            let temp = ["label":items,"clicked":false]
            let node = YUTableViewNode(data: temp as AnyObject, cellIdentifier: "subcell")
            elimination_node.append(node)
        }
        tempmain = ["label":"Elimination","clicked":false,"oldlabel":"Elimination"]
        let elim = YUTableViewNode(childNodes: elimination_node, data: tempmain as AnyObject, cellIdentifier: "Cell")
        
        var activity_node = [YUTableViewNode]()
        for items in activity {
            let temp = ["label":items,"clicked":false]
            let node = YUTableViewNode(data: temp as AnyObject, cellIdentifier: "subcell")
            activity_node.append(node)
        }
        tempmain = ["label":"Activity","clicked":false,"oldlabel":"Activity"]
        let activi = YUTableViewNode(childNodes: activity_node, data: tempmain as AnyObject, cellIdentifier: "Cell")
        
        var addassign_node = [YUTableViewNode]()
        for items in add_assign {
            let temp = ["label":items,"clicked":false]
            let node = YUTableViewNode(data: temp as AnyObject, cellIdentifier: "subcell")
            addassign_node.append(node)
        }
        tempmain = ["label":"Additional Assignments","clicked":false,"oldlabel":"Additional Assignments"]
        let addass = YUTableViewNode(childNodes: addassign_node, data: tempmain as AnyObject, cellIdentifier: "Cell")
        
        var maindata = [YUTableViewNode]()
        maindata.append(bath)
        maindata.append(pc)
        maindata.append(nutri)
        maindata.append(elim)
        maindata.append(activi)
        maindata.append(addass)
        return maindata

    }
    
    func didSelectNode(node: YUTableViewNode, indexPath: NSIndexPath) {
        
        if(reviewstate){
            //disable check mark controls while in review state
            return
        }
        
        if !node.hasChildren () {
            let tempclick = node.data["clicked"] as! Bool
            let str = node.data["label"] as! String
            
            node.data = ["label":str,"clicked":!tempclick]
            
            if(!tempclick){
                //if clicked then add to table2 list
                tableData2.append(node)
            }else{
                //remove item from table2 when unclicked
                let ridx = tableData2.indexOf(node)
                if(ridx != nil){
                    tableData2.removeAtIndex(ridx!)
                }
                
            }
            
            mytable.reloadData()
            
        }
    }
    func setTableProperties () {
        tableData = createNodes()
        tableData2 = [YUTableViewNode]()
        mytable.setDelegate(self)
        mytable.setNodes(tableData)
        mytable.allowOnlyOneActiveNodeInSameLevel = true
        
    }
    
    func setContentsOfCell(cell: UITableViewCell, node: YUTableViewNode) {
        cell.textLabel!.text = node.data["label"] as? String
        
        if !node.hasChildren ()  {
            if( node.data["clicked"] as! Bool ){
                cell.accessoryType = .Checkmark
                
            }else{
                cell.accessoryType = .None
            }
            
        }else{
            cell.textLabel?.font = UIFont(name: "Courier-Bold", size: 18)
        }
        
    }
    
    func heightForIndexPath (indexPath: NSIndexPath) -> CGFloat? {
        return nil;
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.setTableProperties()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

