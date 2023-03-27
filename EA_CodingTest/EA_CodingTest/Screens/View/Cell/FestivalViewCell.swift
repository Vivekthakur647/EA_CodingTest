//
//  FestivalViewCell.swift
//  EA_CodingTest
//
//  Created by VIVEK THAKUR on 24/03/23.
//

import UIKit

class FestivalViewCell: UITableViewCell {
    @IBOutlet weak var bandRecord: UILabel!
    @IBOutlet weak var bandTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    var bandAssociatedWithRecord : String? {
        didSet {
            self.bandTitle.textColor = bandAssociatedWithRecord?.isEmpty != nil ? .black : .red
            self.bandTitle.text = bandAssociatedWithRecord ?? Constants.bandNameMissing
        }
    }
    var festiValsAssociatedForBand : [String]? {
        didSet {
            self.bandRecord.text = festiValsAssociatedForBand?.joined(separator: "\n")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
