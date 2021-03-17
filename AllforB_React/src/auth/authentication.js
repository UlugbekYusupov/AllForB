import React, { useEffect, useState, useMemo, useReducer } from 'react';
import { StyleSheet, ScrollView, View, Text, Button, ActivityIndicator } from 'react-native';
// import { NavigationContainer } from '@react-navigation/native';
// import AsyncStorage from '@react-native-community/async-storage';
// import { AuthContext } from '../contexts/context';
// import RootStack from '../routes/rootStack';
// import MainTab from '../routes/mainTab';

const Authentication = () => {

    initialLoginState = {
        isLoading: true,
        userName: null,
        userToken: null,
      };
    
      loginReducer = (prevState, action) => {
        switch( action.type ) {
          case 'RETRIEVE_TOKEN':
            return {
              ...prevState,
              userToken: action.token,
              isLoading: false,
            };
          case 'LOGIN':
            return {
              ...prevState,
              userName: action.id,
              userToken: action.token,
              isLoading: false,
            };
          case 'LOGOUT':
            return {
              ...prevState,
              userName: null,
              userToken: null,
              isLoading: false,
            };
          case 'REGISTER':
            return {
              ...prevState,
              userName: action.id,
              userToken: action.token,
              isLoading: false,
            };
        }
      };

    const [loginState, dispatch] = React.useReducer(loginReducer, initialLoginState);
    // userToken => LoginToken
    // username => UserId
    const authContext = React.useMemo(() => ({
      
      signIn: async(foundUser) => {

        const LoginToken = String(foundUser[0].userToken);
        const UserId = foundUser[0].username;
  
        try {
          // await AsyncStorage.setItem('userToken', userToken)
          // await AsyncStorage.setItem('userName', userName)
          await AsyncStorage.multiSet([ ['userToken', LoginToken], ['userName', UserId] ])
        } catch(e) {
          console.log(e);
        } 
        console.log( 'set user id: ', UserId );
        console.log( 'set user token: ', LoginToken ); 
        dispatch({ type: 'LOGIN', id: UserId, token: LoginToken });
      },
  
      signOut: async() => {
        const keys = ['userToken', 'userName']
        try {
          // await AsyncStorage.removeItem('userToken')
          // await AsyncStorage.removeItem('userName')
          await AsyncStorage.multiRemove(keys)
        } catch(e) {
          console.log(e);
        }
        dispatch({ type: 'LOGOUT' });
      },
      signUp: async() => { 
      },
    }), [])
  
  
    useEffect( () => {
      setTimeout( async() => {
        // setIsLoading(false);
        let userToken;
        let userName;
        userToken = null;
        userName = null;
        try {
          userToken = await AsyncStorage.getItem('userToken')
          userName = await AsyncStorage.getItem('userName')
        } catch(e) {
          console.log(e); 
        }
        console.log( 'get user id:', userName)
        console.log( 'get user token:', userToken );     
        dispatch({ type: 'REGISTER', token: userToken });
      }, 1000);
    }, []);

    // return (

    // );
}

// export { dispatch, loginState, authContext  }