//
//  MemoryStorageSearchSpec.swift
//  DTModelStorageTests
//
//  Created by Denys Telezhkin on 11.07.15.
//  Copyright (c) 2015 Denys Telezhkin. All rights reserved.
//

import UIKit
import XCTest
@testable import DTModelStorage
import Nimble

class MemoryStorageSearchSpec: XCTestCase {

    var storage = MemoryStorage()

    class TableCell: UITableViewCell,ModelTransfer
    {
        func updateWithModel(model: Int) {
        }
    }
    
    class CollectionCell : UICollectionViewCell, ModelTransfer
    {
        func updateWithModel(model: Int) {
        }
    }
    
    override func setUp() {
        super.setUp()
        self.storage = MemoryStorage()
    }
    
    func testObjectAtIndexPath()
    {
        storage.addItem(1)
        if let _ = storage.objectForCellClass(TableCell.self, atIndexPath: indexPath(0, 0)) {
            
        }
        else {
            XCTFail()
        }
    }
    
    func testCollectionObjectAtIndexPath()
    {
        storage.addItem(2)
        if let _ = storage.objectForCellClass(CollectionCell.self, atIndexPath: indexPath(0, 0)) {
            
        }
        else {
            XCTFail()
        }
    }
    
    func testShouldCorrectlyReturnItemAtIndexPath() {
        storage.addItems(["1","2"])
        storage.addItems(["3","4"], toSection: 1)
        var model = storage.itemAtIndexPath(indexPath(1, 1))
     
        expect(model as? String) == "4"
        
        model = storage.objectAtIndexPath(indexPath(0, 0))
        
        expect(model as? String) == "1"
    }
    
    func testShouldReturnIndexPathOfItem()
    {
        storage.addItems([1,2], toSection: 0)
        storage.addItems([3,4], toSection: 1)
        
        let indexPath = storage.indexPathForItem(3)
        
        expect(indexPath) == NSIndexPath(forItem: 0, inSection: 1)
        
        expect(self.storage.indexPathForItem(5)).to(beNil())
    }
    
    func testShouldReturnItemsInSection()
    {
        storage.addItems([1,2], toSection: 0)
        storage.addItems([3,4], toSection: 1)
        
        let section0 = storage.itemsInSection(0)?.map{ $0 as! Int }
        let section1 = storage.itemsInSection(1)?.map{ $0 as! Int }
        
        expect(section0) == [1,2]
        expect(section1) == [3,4]
    }
    
    func testTableItemIndexPath()
    {
        storage.addItems([1,2,3])
        storage.addItems([4,5,6], toSection: 1)
        storage.addItems([7,8,9], toSection: 2)
        
        let indexPathArray = storage.indexPathArrayForItems([1,5,9])
        expect(indexPathArray) == [indexPath(0, 0),indexPath(1, 1),indexPath(2, 2)]
    }
}
