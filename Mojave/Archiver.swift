//
//  Archiver.swift
//  Mojave
//
//  Created by Andrew Cavanagh on 9/4/16.
//  Copyright © 2016 Andrew Cavanagh. All rights reserved.
//

import Foundation

public enum ArchiverError: Error {
    case invalidCoder
}

public final class Archiver {
    private lazy var archiveQueue: DispatchQueue = {
        return DispatchQueue(label: "archiveQueue")
    }()
    
    public init() {}
    
    public func archive<T: Cacheable>(_ object: T, to url: URL, on queue: DispatchQueue? = nil, completion: ((Result<URL>) -> Void)?) {
        (queue ?? archiveQueue).async {
            do {
                try self.sync_archive(object: object, url: url)
                dispatch_async_safe_main_queue { completion?(Result.success(url)) }
            } catch(let error) {
                dispatch_async_safe_main_queue { completion?(Result.error(error)) }
            }
        }
    }
    
    public func async_unarchive<T: Cacheable>(_ url: URL, of type: T.Type, on queue: DispatchQueue? = nil, with completion: @escaping (Result<T>) -> Void) {
        (queue ?? archiveQueue).async {
            do {
                let object = try self.decode_archive(url: url) as T
                dispatch_async_safe_main_queue { completion(Result.success(object)) }
            } catch(let error) {
                dispatch_async_safe_main_queue { completion(Result.error(error)) }
            }
        }
    }
    
    public func sync_unarchive<T: Cacheable>(_ url: URL) throws -> T {
        return try decode_archive(url: url) as T
    }
    
    public func removeArchive(at url: URL, on queue: DispatchQueue? = nil, with completion: ((Result<URL>) -> Void)?) {
        (queue ?? archiveQueue).async {
            do {
                try FileManager.default.removeItem(at: url)
                dispatch_async_safe_main_queue { completion?(Result.success(url)) }
            } catch(let error) {
                dispatch_async_safe_main_queue { completion?(Result.error(error)) }
            }
        }
    }
}

fileprivate extension Archiver {
    func decode_archive<T: Cacheable>(url: URL) throws -> T {
        let data = try Data(contentsOf: url)
        let coder = Coder(values: Coder.decode(from: data))
        
        guard let object = T(with: coder) else {
            throw ArchiverError.invalidCoder
        }
        return object
    }
    
    func sync_archive<T: Cacheable>(object: T, url: URL) throws {
        let coder = Coder()
        object.encode(with: coder)
        
        try coder.encodeToData().write(to: url)
    }
}
