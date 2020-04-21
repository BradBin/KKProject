//
//  KKHomeModel.swift
//  KKProject_Swift
//
//  Created by youbin on 2020/3/31.
//  Copyright © 2020 Macbook Pro 15.4 . All rights reserved.
//

import Foundation
import HandyJSON


struct KKReturnDta <T:HandyJSON> : HandyJSON {
    var message    : String?
    var returnData : T?
    var stateCode  : Int = 0
}

struct KKResponseData <T : HandyJSON> : HandyJSON {
    var code : Int = 0
    var data : KKReturnDta<T>?
}


class KKHomeModel : HandyJSON{
    var galleryItems:[KKGalleryItemModel]?
    var textItems: [KKTextItemModel]?
    var comicLists: [KKComicListModel]?
    var editTime    : TimeInterval = 0
    
    required init() {}
}


class KKGalleryItemModel: HandyJSON {
    var id: Int = 0
    var linkType: Int = 0
    var cover: String?
    var ext: [KKExtModel]?
    var title: String?
    var content: String?
    required init() {}
}

class KKTextItemModel: HandyJSON {
    var id: Int = 0
    var linkType: Int = 0
    var cover: String?
    var ext: [KKExtModel]?
    var title: String?
    var content: String?
    required init() {}
}

class KKComicListModel: HandyJSON {
//    var comicType: LBUComicType = .none
    var canedit: Bool = false
    var sortId: Int = 0
    var titleIconUrl: String?
    var newTitleIconUrl: String?
    var description: String?
    var itemTitle: String?
    var argCon: Int = 0
    var argName: String?
    var argValue: Int = 0
    var argType: Int = 0
//    var comics:[LBUComicModel]?
    var maxSize: Int = 0
    var canMore: Bool = false
    var hasMore: Bool = false
//    var spinnerList: [LBUSpinnerModel]?
//    var defaultParameters: LBUDefaultParametersModel?
    var page: Int = 0
    required init() {}
}


class KKExtModel: HandyJSON {
    var key: String?
    var val: String?
    required init() {}
}
