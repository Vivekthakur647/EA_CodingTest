//
//  FestsVC+Extension.swift
//  EA_CodingTest
//
//  Created by VIVEK THAKUR on 24/03/23.
//

import UIKit

extension FestsVC : UITableViewDelegate , UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        viewModel.processedRecords.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.processedRecords[section].allBands?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.processedRecords[section].recordName ?? "Record name missing"
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FestivalViewCell", for: indexPath) as? FestivalViewCell
        if let bandAssociatedWithRecord = viewModel.processedRecords[indexPath.section].allBands?[indexPath.row] {
            cell?.bandAssociatedWithRecord = bandAssociatedWithRecord
        }
        if let festiValsAssociatedForBand = viewModel.processedRecords[indexPath.section].allFestivals {
            cell?.festiValsAssociatedForBand = festiValsAssociatedForBand
        }
        
        return cell ?? UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //MARK: Just to show output togather for coding test----
        self.showDetail(error: "\nRecord = 🎙️ \(viewModel.processedRecords[indexPath.section].recordName ?? "") is going to be played by \n\nBand = 🎺 \(viewModel.processedRecords[indexPath.section].allBands?[indexPath.row] ?? "") in \(viewModel.processedRecords[indexPath.section].allFestivals?.count ?? 0) fests . \n\nFestivals  names  = 🎉 \(viewModel.processedRecords[indexPath.section].allFestivals?.joined(separator: " 🎉 and ") ?? "")")
    }
    
        
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int){
        guard let header = view as? UITableViewHeaderFooterView  else { return }
        header.textLabel?.textColor = viewModel.processedRecords[section].recordName != "Record name missing" ? .black : .red
        header.textLabel?.font = UIFont.boldSystemFont(ofSize: 18.0)
        header.textLabel?.text = viewModel.processedRecords[section].recordName ?? "Record name missing"
        header.transform = CGAffineTransform(translationX: 20 , y: 0)
        UIView.animate(withDuration: 0.4) { header.transform = .identity }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return section == 0 ? 32 : 30
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.transform = CGAffineTransform(translationX: self.view.frame.width / 2, y: 0)
        UIView.animate(withDuration: 0.4) { cell.transform = .identity }
    }
}
