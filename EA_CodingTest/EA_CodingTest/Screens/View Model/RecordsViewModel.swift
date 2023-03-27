//
//  RecordsViewModel.swift
//  EA_CodingTest
//
//  Created by VIVEK THAKUR on 24/03/23.
//

import Foundation
class RecordsViewModel: NSObject {
    private var recordService: RecordsServiceProtocol
    
    var reloadTableView: (() -> Void)?
    var processedRecords = [AllRecordsModel]()
    
    init(recordService: RecordsServiceProtocol = RecordsService()) {
        self.recordService = recordService
    }
    
    // MARK: getAllRecords , processed with its bands and festivals playing in -
    func getProcessedRecord() {
        recordService.getRecords { success, records in
            guard success else { return }
            guard let finalRecords = records else { return }
            self.processedRecords = finalRecords
            self.reloadTableView?()
            
        }
    }
}
