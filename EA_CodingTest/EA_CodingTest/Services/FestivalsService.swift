//
//  FestivalsService.swift
//  EA_CodingTest
//
//  Created by VIVEK THAKUR on 24/03/23.
//

import Foundation
import UIKit
protocol RecordsServiceProtocol {
    func getRecords(completion: @escaping (_ success: Bool, _ results: [AllRecordsModel]?) -> ())
}

class RecordsService: RecordsServiceProtocol {
    
    func getRecords(completion: @escaping (Bool, [AllRecordsModel]?) -> ()) {
        HttpRequestHelper().GET(url: EndPoints.festivalList.url, params: ["": ""], httpHeader: .application_json) { success, data  in
            if success {
                do {
                    let object = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
                    if let nonFormatedDict = object as? [[String: AnyObject]] {
                        let formatedDict = self.processedRecordsHierarchy(nonFormatedDict: nonFormatedDict)
                        self.decode(modelType: [AllRecordsModel].self, fromObject: formatedDict) { records in
                            completion(true, records)
                        }
                    }
                } catch {
                    completion(false, nil)
                }
            } else {
                completion(false, nil)
            }
        }
    }
    
    func decode<T>(modelType: T.Type, fromObject: Any, _ genericModel: @escaping (T) -> Void) where T: Decodable {
        do {
            let socketForHostData = try JSONSerialization.data(withJSONObject: fromObject)
            do {
                let finalModel = try JSONDecoder().decode(modelType, from: socketForHostData)
                genericModel(finalModel)
            } catch let err {
                print(err)
            }
        } catch _ { }
    }
    
    // MARK: Below -- Proceesing to meet the Coding test reuqirements i.e see below
    // TODO: Listing out music festival data in a particular manner: at the top level, it should show the band record label, below that it should list out all bands under their management, and below that it should display which festivals they've attended, if any. All entries should be sorted alphabetically.
    
    // MARK: To fetch all sorted records
    func fetchAllRecords (dict :[[String: AnyObject]]) -> [String]{
        var recordArray = [String]()
        dict.forEach { unformattedDictObj in
            guard let unFormatedbands = unformattedDictObj["bands"] as? [[String : Any]] else { return }
            unFormatedbands.forEach { unFormatedbandObj in
                if let recordLable = unFormatedbandObj["recordLabel"] as? String {
                    let modifiedRecordName = recordLable == "" ? "Record name missing" : recordLable
                    if !recordArray.contains(modifiedRecordName) {
                        recordArray.append(modifiedRecordName)
                    }
                }
            }
        }
        return recordArray.sorted()
    }
    // MARK: To fetch all sorted records
    func processedRecordsHierarchy (nonFormatedDict :[[String: AnyObject]]) -> [[String: Any]] {
        var processedDict = [[String: Any]]()
        var recordArray = [String]()
        recordArray = self.fetchAllRecords(dict: nonFormatedDict)
        recordArray.forEach { singleRecord in
            var singleRecordBand = [String]()
            var singleRecordFests = [String]()
            for item in nonFormatedDict {
                if let unFormatedbands = item["bands"] as? [[String : Any]]  {
                    for mainband in unFormatedbands {
                        if let recodLable = mainband["recordLabel"] as? String  {
                            let modifiedRecordName = recodLable == "" ? "Record name missing" : recodLable
                            if modifiedRecordName == singleRecord {
                                if let bandName = mainband["name"] as? String , !singleRecordBand.contains(bandName) {
                                    singleRecordBand.append(bandName)
                                }
                                if let bandsFestName = item["name"] as? String , !singleRecordFests.contains(bandsFestName) {
                                    singleRecordFests.append(bandsFestName)
                                }
                            }
                        }
                    }
                }
            }
            var processedObj = [String : Any]()
            processedObj["recordName"] = singleRecord
            processedObj["allBands"] = singleRecordBand.sorted()
            processedObj["allFestivals"] = singleRecordFests.sorted()
            processedDict.append(processedObj)
        }
        return processedDict
    }
}
