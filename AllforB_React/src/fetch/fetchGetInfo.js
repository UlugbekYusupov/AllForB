import React, { useEffect, useState, useContext } from 'react';
import { StyleSheet, Image, View, Text, Button, Platform, Dimensions, TouchableOpacity, TextInput, StatusBar, Alert } from 'react-native';
import AsyncStorage from '@react-native-community/async-storage';
import Url from '../api/urlBase';


const ResultUserInfo = await fetch(`${Url}/userinfo/getInfo`, {  
    method: 'GET',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=utf-8'    
    }
    ,
    body: JSON.stringify({
      UserId : 1,
      CompanyId : 1,
    })  
      .then((response) => response.json())
      .then((results) => {
        SetUserInfo(results)
    })
     .catch((error)=>{console.error("error")})
})


const SetUserInfo = async (results) => {
  try {
    await AsyncStorage.setItem('ReturnCode', JSON.stringify(results.ReturnCode))
  } catch(e) {
    console.log(e);
  }
// console.log('ReturnCode')
}

// const getUserInfo = async () => {
//   try {
//     return await AsyncStorage.getItem('ReturnCode')
//   } catch(e) {
//     console.log(e)
//   }
//   console.log('Got Data')
// }


// const setLogins = async ({ReturnCode}) => {
  // const firstPair = ["@MyApp_user", "value_1"]
  // const secondPair = ["@MyApp_key", "value_2"]
//   try {
//     const setResults = await AsyncStorage.multiSet([firstPair, secondPair])
//     console.log(setResults)
//   } catch(e) {
//     console.log(e)
//   }
//   console.log("Done.")
// }


// const getLogins = async () => {

//   let values
//   try {
//     values = await AsyncStorage.multiGet(['@MyApp_user', '@MyApp_key'])
//   } catch(e) {
//     console.log(e);
//   }
//   console.log(values)
// }


// const removeUserInfo = async () => {
//   try {
//     await AsyncStorage.removeItem('@MyApp_key')
//   } catch(e) {
//     console.log(e)
//   }
// }

export { ResultUserInfo }