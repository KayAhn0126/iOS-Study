//
//  main.swift
//  CompletionHandler
//
//  Created by Kay on 2023/06/17.
//

/*
 Completion Handler 정리
 */

import Foundation

struct Service {
    static func getDataFromDatabase(completion: @escaping (Int) -> ()) {
        print("start")
        let result: Int = 100
        completion(result)
    }
}

func buttonTapped() {
    print("button tapped")
    Service.getDataFromDatabase { result in
        print("activated from completion handler")
    }
}

buttonTapped()
