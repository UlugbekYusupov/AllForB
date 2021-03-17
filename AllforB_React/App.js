import React, { useEffect, useState, useMemo, useReducer } from 'react';
import { StyleSheet, ScrollView, View, Text, Button, ActivityIndicator } from 'react-native';
import { NavigationContainer } from '@react-navigation/native';
import AsyncStorage from '@react-native-community/async-storage';
import { AuthContext } from './src/contexts/context';
import RootStack from './src/routes/rootStack';
import MainTab from './src/routes/mainTab';


export default function App() {
  // const [isLoading, setIsLoading] = React.useState(true);
  // const [userToken, setUserToken] = React.useState(null);

  initialLoginState = {
    isLoading: true,
    userName: null,
    userToken: null,
    userCode: null,
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
          userCode: action.code,
          isLoading: false,
        };
      case 'LOGOUT':
        return {
          ...prevState,
          userName: null,
          userToken: null,
          userCode: null,
          isLoading: false,
        };
      case 'REGISTER':
        return {
          ...prevState,
          userName: action.id,
          userToken: action.token,
          userCode: action.code,
          isLoading: false,
        };
    }
  };

  const [loginState, dispatch] = React.useReducer(loginReducer, initialLoginState);
  // userToken => LoginToken
  // username => UserId
  const authContext = React.useMemo(() => ({
    
    signIn: async(SetLogins) => {

      // const UserId = AuthUser.UserId;
      // const LoginToken = AuthUser.LoginToken;
      // const ReturnCode = AuthUser.ReturnCode;
      // console.log(SetLogins);

      const SetResults = async () => {
        try {
          // await AsyncStorage.setItem('UserId', SetLogins.UserId)
          // await AsyncStorage.setItem('LoginToken', SetLogins.LoginToken)
          // await AsyncStorage.setItem('ReturnCode', SetLogins.ReturnCode)
          // await AsyncStorage.multiSet([ ['UserId', UserId], ['LoginToken', LoginToken], ['ReturnCode', ReturnCode] ])
        } catch(e) {
          console.log(e);
        } 
        // console.log("set UserId: ", SetLogins.UserId);
        // console.log("set LoginToken : ", SetLogins.LoginToken);
        // console.log("set ReturnCode : ", SetLogins.ReturnCode);
        // console.log(SetLogins);
      }

      dispatch({ type: 'LOGIN', id: SetResults.UserId, token: SetResults.LoginToken, code: SetResults.ReturnCode });
    },

    signOut: async() => {
      // setUserToken(null);
      // setIsLoading(false);
      const keys = ['LoginToken', 'UserId', 'ReturnCode']
      try {
        await AsyncStorage.multiRemove(keys)
      } catch(e) {
        console.log(e);
      }
      dispatch({ type: 'LOGOUT' });
    },
    signUp: async() => {
      // setUserToken('fgkj');
      // setIsLoading(false);    
    },
  }), [])


  useEffect( () => {
    setTimeout( async() => {
      // setIsLoading(false);
      let userName;
      let userToken;
      let userCode;
        userName = null;
        userToken = null;
        userCode = null;
        try {
          userName = await AsyncStorage.getItem('UserId')
          userToken = await AsyncStorage.getItem('LoginToken')
          userCode = await AsyncStorage.getItem('ReturnCode')
        } catch(e) {
          console.log(e); 
        }
      console.log( 'get user id:', userName)
      console.log( 'get user token:', userToken );     
      console.log( 'get user ReturnCode:', userCode );    
      dispatch({ type: 'REGISTER', token: userToken });
    }, 1000);
  }, []);


  if ( loginState.isLoading ) {
    return (
      <View style={{ flex: 1, justifyContent: 'center', alignItems: 'center' }} >
        <ActivityIndicator size="large" />
      </View>
    );
  }

  return (
    <AuthContext.Provider value={authContext}>
      <NavigationContainer>
        { loginState.userToken !== null ? (
          <MainTab />
          )
        :
          <RootStack /> 
        }
      </NavigationContainer>
    </AuthContext.Provider> 
  )
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
