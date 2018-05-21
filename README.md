## Overview
This repo is dedicated to show my approach to building iOS apps involving MVVM architecture, RxSwift framework, Coordinator pattern in order to create robust and statically typed system within the app.

All UI layout is done using SnapKit framework.

App consists of 3 screens:
* Main - Albums and posts lists
* Comments - for selected post 
* Photos - for selected album

API provider - https://jsonplaceholder.typicode.com/

Networking is abstracted in a protocol - ```NetworkService```. There are two concrete implementations:
* ```BasicNetworkServiceImpl``` - regular API client.
* ```CachedNetworkServiceImpl``` - API client with caching support.

Internal caching implemented using CoreData baked by a single entity - ```CacheEntity```.
