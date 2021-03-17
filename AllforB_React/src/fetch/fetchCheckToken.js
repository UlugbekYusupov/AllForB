import React, { useEffect, useState, useContext } from 'react';
import { StyleSheet, Image, View, Text, Button, Platform, Dimensions, TouchableOpacity, TextInput, StatusBar, Alert } from 'react-native';
// import AsyncStorage from '@react-native-community/async-storage';
// import Url from '../api/urlBase';

const ResultCheckToken = await fetch(`${Url}/userlogin/checkToken`, {  
    method: 'GET',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=utf-8'    
    }
    ,
    body: JSON.stringify({
      UserId : 1,
      SavedToken : "" //  CheckLogin에서 리턴된 토큰값으로 넣고 테스트
    })  
      .then((response) => response.json())
      .then((response) => {
      setLogin(response.ReturnCode)
    })
    .catch((error)=>{console.error("error")})
})

const setCheckToken = async (ReturnCode) => {
try {
  await AsyncStorage.setItem('ReturnCode', JSON.stringify(ReturnCode))
} catch(e) {
  console.log(e);
}
// console.log('ReturnCode')
}

const getCheckToken = async () => {
//   try {
  return await AsyncStorage.getItem('ReturnCode')
//   } catch(e) {
//     console.log(e)
//   }
//     console.log('Got Data')
//   }
}

const removeCheckToken = async () => {
  try {
    await AsyncStorage.removeItem('@MyApp_key')
  } catch(e) {
    console.log(e)
  }
}

export { ResultCheckToken }