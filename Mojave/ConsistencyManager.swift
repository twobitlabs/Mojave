//
//  ConsistencyManager.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 8/30/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

public protocol ConsistencyManagerListener: class {
    func didUpdate(model: DataSourceModel)
}

public final class ConsistencyManager {
    private let queue = DispatchQueue(label: "mojave.consistencyManager")
    private var listeners = [String : NSHashTable<AnyObject>]()
    private var models = [String : DataSourceModel]()
    
    public static let sharedInstance = ConsistencyManager()
    
    internal init() {}
    
    public func registerShared<T: DataSourceModel>(model: T) {
        guard models[model._identifier] == nil else { fatalError("Model of type \(model.self) already registered.") }
        models[model._identifier] = model
    }
    
    public func updateShared<T: DataSourceModel>(model: T) {
        guard let _model = models[model._identifier] else { fatalError("Model \(model.self) not registered.") }
        models[_model._identifier] = model
        notify(with: model)
    }
    
    public func model<T: DataSourceModel>(forShared modelType: T.Type) -> T? {
        guard let sharedModel = models[modelType.__identifer] as? T else { return nil }
        return sharedModel
    }
    
    public func add<T: DataSourceModel>(listener: ConsistencyManagerListener, for modelType: T.Type) {
        dispatch_async_safe_main_queue {
            if self.listeners[modelType.__identifer] == nil {
                self.listeners[modelType.__identifer] = NSHashTable(options: .weakMemory)
            }
            
            self.listeners[modelType.__identifer]!.add(listener)
        }
    }
    
    private func notify<T: DataSourceModel>(with model: T) {
        dispatch_async_safe_main_queue {
            guard let newModel = self.models[model._identifier] else { fatalError("Misconfigured ConsistencyManager") }
            guard let listeners = self.listeners[model._identifier] else { return }
            
            let enumerator = listeners.objectEnumerator()
            while let value: Any = enumerator.nextObject() {
                if let value = value as? ConsistencyManagerListener {
                    value.didUpdate(model: newModel)
                }
            }
        }
    }
}

