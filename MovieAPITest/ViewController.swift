//
//  ViewController.swift
//  MovieAPITest
//
//  Created by 권유정 on 2022/08/17.
//

import UIKit
struct BoxOffice: Decodable{
    let boxOfficeResult: BoxOfficeResult
}
struct BoxOfficeResult: Decodable{
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieData]
}
struct MovieData: Decodable{
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}
class ViewController: UIViewController {
    
    let key = "646e2c7f0a11dd7ff2d8ccbd89b085aa"
    var targetDate = "20220817"
    
    // *1-2.
    var dataStructure: BoxOffice? // 앞으로 json 데이터를 받을 자료구조타입의 변수

    override func viewDidLoad() {
        super.viewDidLoad()
        // *1-3. url 생성
        print("시작")
        let baseURL = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/" +
        "boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(targetDate)"
        
        guard let url = URL(string: baseURL) else { return print("안됨")}
        // *1-4. 준비된 url로 데이터를 받아오는 작업
        URLSession.shared.dataTask(with: url) { data, response, error in
            // 전달 받은 data, response, error 를 이용해 처리하는 블럭(클로저)
            //에러가 발생했는지 먼저 발생
            guard error == nil else{
                print(error!)
                return
            }
            guard let resData = data else {return}
            do {
                self.dataStructure = try JSONDecoder().decode(BoxOffice.self, from: resData)
                DispatchQueue.main.async(execute: {
                    if let list = self.dataStructure?.boxOfficeResult.dailyBoxOfficeList{
                        for movie in list{
                            print("\(movie.rank). \(movie.movieNm) : \(movie.rankInten)")
                        }
                    }
                })
            }catch{
                print("Data Parsing Error")
            }
        }.resume()
        print(dataStructure)
    }

}

