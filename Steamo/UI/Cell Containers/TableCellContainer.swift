//
//  TableCellContainer.swift
//  Steamo
//
//  Created by Max Kraev on 26.11.2019.
//  Copyright © 2019 Max Kraev. All rights reserved.
//

import UIKit

class TableCellContainer<View: UIView>: UITableViewCell {
    public private(set) lazy var containedView: View = View(frame: .zero)

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setup()
    }

    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setup() {
        backgroundColor = .clear

        contentView.addSubview(containedView)
        containedView.snp.makeConstraints { maker in
            maker.edges.equalToSuperview()
        }
    }
}
