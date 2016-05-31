//
//  Handler.swift
//  Slacket
//
//  Created by Jakub Tomanik on 31/05/16.
//
//

import Foundation

protocol Handler {}

/*
 
 Handler responsibilities:
 
 * Reacting to Router reqests and invoking appropirate Service with data it requires
 * Responding to Router with properly formated data
 
 Entities are plain data objects, preferably Value types.
 Entities are **not** the data access layer, as this is a Gateway responsibility.
 Entities are pretty straight forward and what you would expect. They embody some type of data and act as the “payload” that gets passed around between the other objects.
 
 */