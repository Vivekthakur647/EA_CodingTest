//
//  FestsVC.swift
//  EA_CodingTest
//
//  Created by VIVEK THAKUR on 24/03/23.
//

import UIKit
class FestsVC: UIViewController {
        
    lazy var viewModel = {
        RecordsViewModel()
    }()
    
    @IBOutlet weak var festivalsTableView : UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTableView()
        initViewModel()
    }

    func setUpTableView() {
        festivalsTableView.delegate = self
        festivalsTableView.dataSource = self
    }
    
    func initViewModel() {
        viewModel.getProcessedRecord()
        
        // Reload festivales closure
        viewModel.reloadTableView = { [weak self] in
            DispatchQueue.main.async {
                self?.festivalsTableView.reloadData()

            }
        }
    }

    // MARK: refreshAction - To refresh api call to easily test this coding test
    @IBAction func refreshAction(_ sender: Any) {
        viewModel.getProcessedRecord()
    }
}

