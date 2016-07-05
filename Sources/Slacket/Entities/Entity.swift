//
//  Entity.swift
//  Slacket
//
//  Created by Jakub Tomanik on 20/05/16.
//
//

import Foundation

protocol Entity {}

/*
 
 Entity responsibilities:
 
 * Represent data
 
 Entities are plain data objects, preferably Value types.
 Entities are **not** the data access layer, as this is a Gateway responsibility.
 Entities are pretty straight forward and what you would expect. They embody some type of data and act as the “payload” that gets passed around between the other objects.
 
 */