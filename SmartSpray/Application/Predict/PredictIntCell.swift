//
//  PredictIntRow.swift
//  SmartSpray
//
//  Created by Skyler Bala on 9/13/18.
//  Copyright © 2018 SkylerBala. All rights reserved.
//

import Foundation
import Eureka

public class PredictIntCell: Cell<Int>, CellType {

    public override func setup() {
        super.setup()
    }
    
    public override func update() {
        super.update()
    }
}

// The custom Row also has the cell: CustomCell and its correspond value
public final class PredictIntRow: Row<PredictIntCell>, RowType {
    required public init(tag: String?) {
        super.init(tag: tag)
    }
    
    public func cellSetup(_ callback: @escaping ((PredictIntCell, PredictIntRow) -> Void)) -> PredictIntRow {
        self.cell.height = { UITableViewAutomaticDimension }
        return self
    }
}

