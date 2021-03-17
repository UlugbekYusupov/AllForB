import React, { useEffect, useState } from 'react';
import { Text, View, StyleSheet } from 'react-native';
// import { useNavigation, useRoute } from '@react-navigation/native';
import { FlatList, ScrollView } from 'react-native-gesture-handler';
import AsyncStorage from '@react-native-community/async-storage';
import Url from '../api/urlBase';


const recordTable = () => {

    const [resultList, setResultList] = useState();
    const [userid, setuserid] = useState();
    const retable = () => {
        setTimeout( async() => {
            // setIsLoading(false);
            let userid;
            //let companyid;
              userid = null;
              //companyid = null;
              try {
                userid = await AsyncStorage.getItem('UserId')
                setuserid(userid)
                //setuserid(userid = await AsyncStorage.getItem('UserId'))
                //companyid = await AsyncStorage.getItem('companyId')
              } catch(e) {
                console.log(e); 
              }
            console.log( 'get user id:', userid)
            //setuserid(userid)
            //console.log( 'get user companyid:', companyid );      
            //dispatch({ type: 'REGISTER', token: userToken });
            fetch(`${Url}/attendance/getDailyList`,{
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json;charset=utf-8',    
                }
                ,
                body: JSON.stringify({
                    UserId: userid,
                    FromDate: '2021-01-01 00:00:00',
                    ToDate: '2021-02-28 00:00:00'
                })
            }) 
            .then((response) => response.json())
            .then((results) =>{
                console.log("======================");
                console.log(results)
                
                if( results.ResultList.length >0)
                {
                    console.log(results.ResultList[0].InOutTimeInfo);
                }
                else{
                    console.log("값이없음.");
                }
                setResultList(results.ResultList)
                //setrelist(results.ResultList)
                //setInoutType(results.InoutTypeId)
                //setcounter( results.ExpireDateTime );
            })
            .catch((error) => {
                console.error(error)
            })
        }, 1000);
    }
    
    useEffect(() => {
        retable();
    }, [userid])

    const funcRenderItem = data  => {
        return( 
          <View style={{borderWidth: 1, borderColor: '#f2aa4c'}}>
            <Text style={styles.listRightText}>날짜: {data.item.IssueDate}</Text> 
            <Text style={styles.listcenterText}>{data.item.InOutTimeInfo}</Text>
          <Text></Text> 
          </View>
        );
      };

    
    return (
        <View>
            <View style={styles.tableView}>
                <FlatList
                    data={resultList}
                    renderItem = {funcRenderItem}
                />
            </View>
        </View>
    )
}
export default recordTable;


const styles = StyleSheet.create({
    tableView: {
        // alignItems: 'center',
        alignSelf: 'center',
        // justifyContent: 'center',
        width: '100%',
        
        // borderWidth: 1,
        //paddingTop: 10,
        // marginTop: 10,
       // backgroundColor: '#F2AA4C'
    },

    titleView: {
       // flexDirection: 'row',
        alignSelf: 'center',
        // paddingTop: 10,
        // marginTop: 3,
        // marginBottom: 3,
        // paddingBottom: 5,
        // borderWidth: 1,
        // borderColor: 'black',
    },

    titleLeftText: {
        textAlign: 'center',
        fontSize: 15,
        fontWeight: "bold",
        
        
        // paddingTop: 5,
    },
    titlecenterText: {
        textAlign: 'center',
        fontSize: 15,
        fontWeight: "bold",
        
        // paddingTop: 5,
    },
    titleRightText: {
        textAlign: 'center',
        fontSize: 15,
        fontWeight: "bold",
       
        // paddingTop: 5,
    },

    scrollContainer: {
         width: '100%',
         height: 200,
         //paddingTop: 5,
        marginTop: -10,
        //backgroundColor: '#F2AA4C'
    },

    listView: {
        flexDirection: 'row',
        //alignSelf: 'center',
        // paddingTop: 10,
        height: 60,
        marginTop: 10,
        borderWidth: 1
        // marginBottom: 3,
        // paddingBottom: 5,
        // borderWidth: 1,
        // borderColor: 'black',
    },

    listLeftText: {
        textAlign: 'center',
        alignItems: 'center',
        fontSize: 18,
        fontWeight: "bold",
        borderColor: '#F2AA4C',
        backgroundColor: '#F2AA4C',
        borderWidth: 1,
        borderRadius: 50,
        width: 50,
        height: 50,
        //marginBottom: 15,
        // paddingTop: 5,
        color: '#101820',
    },
    listcenterText: {
        textAlign: 'center',
        fontSize: 18,
        fontWeight: "bold",
        color: '#F2AA4C',
        marginLeft: 25,
        //marginTop: -49
        //alignItems: 'flex-start'
        // paddingTop: 5,
    },
    listRightText: {
        textAlign: 'center',
        fontSize: 18,
        fontWeight: "bold",
        paddingTop: 20,
        color: '#F2AA4C',
        marginLeft: 25
        // paddingTop: 5,
    },

});