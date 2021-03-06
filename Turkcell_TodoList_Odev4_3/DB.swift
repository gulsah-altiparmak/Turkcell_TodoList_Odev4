//
//  DB.swift
//  Turkcell_TodoList_Odev4_3
//
//  Created by Gulsah Altiparmak on 23.01.2021.
//

import Foundation
import SQLite
struct Todo {
    var id:Int64 = 0
    var product:String = ""
    var amount:String = ""
    var date:String = ""
    //var category:String = ""
    var categoryId:Int = 0
    var isDeleted:Bool = false
    var isDone:Bool = false

    
}
struct Category {
    var cid:Int = 0
    var categoryName:String = ""
    var categoryImage: Int = 0

    
}
class DB {
    var db:Connection!
    var tableTodo = Table("todo")
    
    let id = Expression<Int64>("id")
    let product = Expression<String?>("product")
    let amount = Expression<String?>("amount")
    let date = Expression<String?>("date")
    let categoryId = Expression<Int>("categoryId")
    let isDeleted = Expression<Bool>("isDeleted")
    let isDone = Expression<Bool>("isDone")
    
    var categoryTable = Table("category")
    let cid = Expression<Int>("cid")
    let categoryName = Expression<String>("categoryName")
    let categoryImage = Expression<Int>("categoryImage")
    
  
    

    
    let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0]
    
    func fncConnection() {
        let dbPath = path + "/db.sqlite3"
        print("Full path: \(dbPath)")
        db = try! Connection(dbPath)
        
        do {
            try db.scalar(tableTodo.exists)
        } catch  {
            
            try! db.run(tableTodo.create { t in
                t.column(id, primaryKey: true)
                t.column(product)
                t.column(amount)
                t.column(date)
                t.column(categoryId)
                t.column(isDeleted)
                t.column(isDone)
               
            })
            
        }
        do {
            try db.scalar(categoryTable.exists)
        } catch  {
            try! db.run(categoryTable.create{ t in
                t.column(cid,primaryKey: true)
                t.column(categoryName)
                t.column(categoryImage)
                
            })
        }
        
    }

    func todoInsert(product:String, amount:String,date:String, categoryId:Int) -> Int64 {
        do {
            let insert = tableTodo.insert(self.product <- product, self.amount <- amount, self.date <- date,self.categoryId <- categoryId, self.isDeleted <- false, self.isDone <- false)
            return try db.run(insert)
        } catch  {
            return -1
        }
    }
    func todoList(isdone:Bool) -> [Todo] {
        var arr:[Todo] = []
        let todos = try! db.prepare(tableTodo.filter(isDeleted == false && isDone == isdone))
        
        for item in todos{
            let td = Todo(id: item[id], product: item[product]!, amount: item[amount]!, date: item[date]!, categoryId: item[categoryId])
            arr.append(td)
        }
        return arr
    }
    
    
    func categoryList() -> [String] {
        var arr: [String] = []
        let categories = try! db.prepare(categoryTable)
        for item in categories{
            let category = Category( categoryName: item[categoryName])
            arr.append(String(category.categoryName))
        }
        print(categories)
        return arr
    }
    func todoDelete(todoId:Int64 ) -> Int {
        let alice = tableTodo.where(id == todoId)
        

        return try! db.run(alice.update(isDeleted <- true))
    }
    
    func todoUpdate(todoId:Int64, isdone:Bool) {
        let alice = tableTodo.filter(id == todoId)

        try! db.run(alice.update(isDone <- isdone))
        
    }
    //kategori ekleme DB
/*  func categoryInsert( categoryName:String, categoryImage:Int) {
      
        
        do {
            let insert = categoryTable.insert(self.categoryName <- categoryName, self.categoryImage <- categoryImage)
           try db.run(insert)
        } catch  {
          
        }
    }
 */
    


        
    }
    


