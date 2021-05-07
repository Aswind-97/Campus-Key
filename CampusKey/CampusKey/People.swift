//
//  people.swift
//  CampusKey
//
//  Created by Javier Aguayo Jr on 11/9/20.
//

import Foundation

struct People: Codable{
    
    //var individuals_id:String = ""
    var first_name:String = ""
    var last_name:String = ""
    var email:String = ""
    var affiliation:String = ""
}
/*
{"status":"200","success":"true","type":"people","people":{"individuals_id":"members:106458467","parent_entities_id":null,"entity_type":"Individual","display_name":"Javier Aguayo","description":null,"record_status":"Active","first_name":"Javier","middle_name":null,"last_name":"Aguayo","common_name":"Javier Aguayo","email":"javier.aguayo.882@my.csun.edu","gender":null,"biography":null,"confidential":0,"deceased":0,"affiliation":"student","rank":null,"appt_year":null,"affiliation_status":"Active","profile_image":null,"email_u_r_i":"javier.aguayo.882","contacts":[],"image":null}}
*/
