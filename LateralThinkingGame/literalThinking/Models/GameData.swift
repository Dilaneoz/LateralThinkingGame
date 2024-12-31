//
//  GameData.swift
//  literalThinking
//
//  Created by Dilan Öztürk on 30.12.2024.
//

import UIKit

struct GameData {
 

    static let scenarioImages: [[String]] = [["hotelRoom2","missingWoman2","lockedHouse2","lastRecord2","bankVault2","target2","silentPrisoner2","theWitness2","drawnLine2","corpseInDesert2"],
    ["corpseInDesert2","lockedHouse2","lastRecord2","","","","","","",""],
    ["lockedHouse2","lastRecord2","","","","","","","","","","",""],
    ["","","","","","","","","",""],
    ["","","","","","","","","",""],
    ["","","","","","","","","",""]]
    
    static let visualImages: [[String]] = [["hotelRoom","missingWoman","lockedHouse","lastRecord","bankVault","target","silentPrisoner","theWitness","drawnLine","corpseInDesert"],
    ["corpseInDesert","lockedHouse","","","","","","","",""],
    ["","","","","","","","","",""],
    ["","","","","","",""],
    ["","","","","","",""]]
    
    static let gameTitle: [[String]] = [["Indoor Hotel Room","The Missing Woman","Locked House","Last Record","The Corpse in the Locked Safe","Name on Target","The Silent Prisoner","The Witness","The Drawn Line","A Corpse in the Middle of the Desert"],
    ["xyz", "zyx", "xxx","","","","","","",""],
    ["","","","","","","","","","","","","",""],
    ["","","","","","","","","","","","","",""],
    ["","","","","","","","","","","","","",""]]
    
    static let gameScenarios: [[String]] = [["Bir adam bir otel odasında, odanın kapısı içeriden zincirle kapatılmış şekilde ölü bulunur. Odanın camları içeriden kilitlidir ve kırılmamıştır.","Bir kadın gece evde yalnızken kapıyı kilitler ve yatmaya gider. Sabah uyandığında, evin kapısı hala kilitlidir, ancak evde bir başkasının ayak izleri vardır.","Bir kadın gece evde yalnızken kapıyı kilitler ve yatmaya gider. Sabah uyandığında, evin kapısı hala kilitlidir, ancak evde bir başkasının ayak izleri vardır.","","","","","","",""],
    ["xxx","yyy","zzz","","","","","","",""],
    ["","","","","","","","","","","","","",""],
    ["","","","","","","","","","","","","",""],
    ["","","","","","","","","","","","","",""]]
    
    static let scenariosLabelColors : [[UIColor]] = [[.black, .black, .white, .black, .black],
    [.white, .white, .black, .white, .white, .black],
    [.white, .white, .black, .white, .white, .black],
    [.white, .white, .black, .white, .white, .black],
    [.white, .white, .black, .white, .white, .black]]
    
    static let scenarioTitleColor: [[UIColor]] = [[.black, .black, .white, .black, .black],
    [.white, .white, .black],
    [.white, .white, .black],
    [],
    []]
    
    static let solutionButtonColor: [[UIColor]] = [[.black, .black, .white, .black, .black],
    [.white, .white, .black],
    [.white, .white, .black],
    [],
    []]
    
    static let solutionButtonFrameColor: [[UIColor]] = [[.black, .black, .white, .black, .black],
    [.white, .white, .black],
    [.white, .white, .black],
    [],
    []]
    
    static let checkmarkButton: [[UIColor]] = [[.black, .black, .white, .black, .black],
    [.white, .white, .black],
    [.white, .white, .black],
    [],
    []]
    
    
    
}
