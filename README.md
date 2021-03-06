Movies DB
======

![Swift](https://img.shields.io/badge/Swift-4.1-green.svg)

Movies DB is an iOS application developed to list the Top Rated and Popular movies based on [The Movie DB](https://www.themoviedb.org).

Architecture
--------
* **MVVM-C/W**

```We are using MVVM as base of the architecture plus C/W(Controler or Worker), where we call one or more requests to server if it's necessay because the original MVVM use to use the ViewModel to call the requests to server.```


Git
--------
* [GitFlow](https://datasift.github.io/gitflow/IntroducingGitFlow.html)

Libraries
--------

* [RxSwift](https://github.com/ReactiveX/RxSwift)
* [RxCocoa](https://github.com/ReactiveCocoa/ReactiveCocoa)
* [Realm](https://realm.io)
* [RealmSwift](https://realm.io)
* [Alamofire](https://github.com/Alamofire/Alamofire)
* [Fabric/Crashlytics](https://fabric.io/home)
* [Kingfisher](https://github.com/onevcat/Kingfisher)
* [R.swift](https://github.com/mac-cain13/R.swift)

Features
--------

* **Top rated**
```List all top rated movies```

* **Popular**
```List all popular movies```

* **Movie detail**
```Show the movie detail when the item in the list will be touched```

Screenshots
------------

![iphone1](/screenshots/iphone1.png?raw=true)
![iphone2](/screenshots/iphone2.png?raw=true)
![iphone3](/screenshots/iphone3.png?raw=true)
![iphone4](/screenshots/iphone4.png?raw=true)
![iphone5](/screenshots/iphone5.png?raw=true)

Requirements
------------

* iOS 11  or later
* Xcode 9.4.1 or later
* Swift 4.1  or later
* [CocoaPods](https://cocoapods.org)

Instalation
------------
* Using terminal, go to the project folder where there is the **Podfile** and execute the command bellow.

`pod install` 


Contribution
------------

Discussion and pull requests are welcomed

Authors
------------

* Jáder Nunes


License
-------

Movies is under MIT license. See the [LICENSE](LICENSE) for more info.
