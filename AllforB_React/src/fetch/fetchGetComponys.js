import React, { useEffect, useState, useContext } from 'react';
import { StyleSheet, Image, View, Text, Button, Platform, Dimensions, TouchableOpacity, TextInput, StatusBar, Alert } from 'react-native';
// import AsyncStorage from '@react-native-community/async-storage';
// import Url from '../api/urlBase';

const ResultComponys = await fetch(`${Url}/userlogin/getCompanys`, {  
    method: 'GET',
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json;charset=utf-8'    
    }
    ,
    body: JSON.stringify({
      InputedAccountId: "jykim@gmail.com"
    })  
      .then((response) => response.json())
      .then((response) => {
      setLogin(response.ReturnCode)
    })
    .catch((error)=>{console.error("error")})
})

const setComponys = async (ReturnCode) => {
try {
  await AsyncStorage.setItem('ReturnCode', JSON.stringify(ReturnCode))
} catch(e) {
  console.log(e);
}
// console.log('ReturnCode')
}

const getComponys = async () => {
//   try {
  return await AsyncStorage.getItem('ReturnCode')
//   } catch(e) {
//     console.log(e)
//   }
//     console.log('Got Data')
//   }
}

removeComponys = async () => {
  try {
    await AsyncStorage.removeItem('@MyApp_key')
  } catch(e) {
    console.log(e)
  }
}

export { ResultComponys }