import React, { useEffect, useState, useContext } from 'react';
import { StyleSheet, Image, View, Text, Button, Platform, Dimensions, TouchableOpacity, TextInput, StatusBar, Alert } from 'react-native';
// import AsyncStorage from '@react-native-community/async-storage';
// import Url from '../api/urlBase';

// const ResultLogin = await fetch(`${Url}/userlogin/checkLogin`, {  
//     method: 'POST',
//     headers: {
//       'Accept': 'application/json',
//       'Content-Type': 'application/json;charset=utf-8'    
//     }
//     ,
//     body: JSON.stringify({
//       accountId: data.username,
//       pwdCrypt: data.password,
//       IsLoginSave : true,
//     })  
//       .then((response) => response.json())   
//       .then((results) => {
//         console.log(results);
      // setLogin(results.LoginToken)

//     })
//     .catch((error)=>{console.error("error")})
// })


// const setLogin = async (results) => {
//   try {
//     await AsyncStorage.setItem('LoginToken', JSON.stringify(results.LoginToken))
//   } catch(e) {
//     console.log(e);
//   }
// console.log('LoginToken')
// }


// const getLogin = async () => {
//   try {
  // return await AsyncStorage.getItem('ReturnCode')
//   } catch(e) {
//     console.log(e)
//   }
//     console.log('Got Data')
//   }
// }


// const setLogins = async ({result}) => {
//   const UserId = ["UserId", result.UserId]
//   const LoginToken = ["LoginToken", result.LoginToken]
//   try {
//     const setResults = await AsyncStorage.multiSet([UserId, LoginToken])
//     console.log(setResults)
//   } catch(e) {
//     console.log(e)
//   }
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



// removeLogin = async () => {
//   try {
//     await AsyncStorage.removeItem('LoginToken')
//   } catch(e) {
//     console.log(e)
//   }
// }

export { ResultLogin }