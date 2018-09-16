# Uncomment this line to define a global platform for your project
platform :ios, '11.0'
# Uncomment this line if you're using Swift
use_frameworks!
# ignore all warnings from all pods
inhibit_all_warnings!

def prod_pods
    pod 'Alamofire', '~> 4.7'
    pod 'RxSwift', '~> 4.0'
    pod 'RxCocoa', '~> 4.0'
    pod 'RealmSwift'
    pod 'Kingfisher', '~> 4.0'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'R.swift'
end

target 'MoviesDB' do
    prod_pods
end

target 'MoviesDBTests' do
    prod_pods
end
