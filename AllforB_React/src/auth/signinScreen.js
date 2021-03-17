import React, { useEffect, useState, useContext } from 'react';
import { StyleSheet, Image, View, Text, Button, Platform, Dimensions, TouchableOpacity, TextInput, StatusBar, Alert } from 'react-native';
import AsyncStorage from '@react-native-community/async-storage';
import * as Animatable from 'react-native-animatable';
import LinearGradient from 'react-native-linear-gradient';
import FontAwesome from 'react-native-vector-icons/FontAwesome';
import { AuthContext } from '../contexts/context';
//import {NavigationContainer} from '@react-navigation/native';
import MainLogo from '../assets/mainLogo';
// import Users from '../auth/users';
import Url from '../api/urlBase';
import SplashScreen from './splashScreen';
// import { useNavigation } from '@react-navigation/native';


const SignInScreen = ({ navigation, props }) => {

  const [data, setData] = React.useState({ 
    username: '',
    password: '',
    check_textInputChange: false,
    secureTextEntry: true,
    isValidUser: true,
    isValidPassword: true,
  });

  const { signIn } = React.useContext(AuthContext);

  const textInputChange = (val) => {
    if( val.trim().length > 4 ) {
      setData({
        ...data,
        username: val,
        check_textInputChange: true,
        isValidUser: true,
      });
    } else {
      setData({
        ...data,
        username: val,
        check_textInputChange: false,
        isValidUser: false,
      });
    }
  }

  const textInputPChange = (val) => {
    if( val.trim().length > 4 ) {
      setData({
        ...data,
        password: val,
        check_textInputChange: true,
        isValidPassword: true,
      });
    } else {
      setData({
        ...data,
        password: val,
        check_textInputChange: false,
        isValidPassword: false,
      });
    }
  }

  const handlePasswordChange = (val) => {
    if( val.trim().length > 8 ) {
      setData({
        ...data,
        password: val,
        //check_textInputChange: true,
        isValidPassword: true,
      });
    } else {
      setData({
        ...data,
        password: val,
        //check_textInputChange: false,
        isValidPassword: false,
      });
    }
  }

  const handleValidUser = (val) => {
    if( val.trim().length > 4 ) {
      setData({
        ...data,
        username: val,
        //check_textInputChange: true,
        isValidUser: true,
      });
    } else {
      setData({
        ...data,
        username: val,
        //check_textInputChange: true,
        isValidUser: false,
      });
    }
  }

  const updateSecureTextEntry = () => {
    setData({
      ...data,
      secureTextEntry: !data.secureTextEntry,
    });
  }

  const [userid, setuserid] = useState();
  const [userpwd, setuserpwd] = useState();
  const [acId, setAcId] = useState();
  //const [recode, setrecode] = useState();
 // const [remessage, setremessage] = useState();

  const loginHandle = (username, password) => {
    const id = userid;
    const pwd = userpwd;
    
    // if( id !== username ) {
    //   Alert.alert('틀린 아이디 입니다.'), [
    //     {text: '확인'}
    //   ]
    //   return;
    // }
    // else if( pwd !== password ) {
    //   Alert.alert('틀린 비밀번호 입니다.'), [
    //     {text: '확인'}
    //   ]
    //   return;
    // }

    // if( id !== username && pwd !== password ) {
    //   Alert.alert('아이디 와 비밀번호를 다시 한번 확인해 주세요.'), [
    //     {text: '확인'}
    //   ]
    //   return;
    // }

    // const AuthUser = () => {
      // if( id == username && pwd == password ) {
        fetch(`${Url}/userlogin/checkLogin`, {  
          method: 'POST',                                                        
          headers: {
            'Accept': 'application/json',
            'Content-Type': 'application/json;charset=utf-8',    
          }
          ,
          body: JSON.stringify({   
            AccountId: id,
            PwdCrypt: pwd,
            IsLoginSave : false,
          })  
          } )
          .then((response) => response.json())
          .then((results) => {   
            console.log(results)
            console.log(results.AccountId)
            
            //setrecode(results.ReturnCode)
           // setremessage(results.ExceptionMessage)
            // if(results.ReturnCode != 0){
            //   //SignInScreen();
            //   Alert.alert(results.ExceptionMessage)
            // }else{
            //   SetLogins(results)
            // }
            if(results.ReturnCode === 0){
              SetLogins(results)
              signIn({ SetLogins });
            }else{
              Alert.alert(results.ExceptionMessage)
              navigation.navigate('SplashScreen')
            }
            //SetLogins(results)
            // console.log(accountId)
          })
          .catch((error)=>{
            console.error("error")
            //Alert.alert(results.ExceptionMessage)
          })
      // }
    // }


    // 입력
    const SetLogins = async (results) => {
      try {
        await AsyncStorage.setItem('UserId', JSON.stringify(results.UserId))
        await AsyncStorage.setItem('LoginToken', JSON.stringify(results.LoginToken))
        await AsyncStorage.setItem('ReturnCode', JSON.stringify(results.ReturnCode))
        await AsyncStorage.setItem('AccountId', JSON.stringify(results.AccountId))
      } catch(e) {
        console.log(e);
      }
      console.log("set UserId: ", results.UserId);
      console.log("set AccountId : ", results.AccountId)
      console.log("set LoginToken : ", results.LoginToken);
      console.log("set ReturnCode : ", results.ReturnCode);
      console.log(results)
    }


    // const SetLogins = async (results) => {
    //   try {
    //     await AsyncStorage.setItem('SetResults', JSON.stringify(results))
    //     await AsyncStorage.setItem('UserId', JSON.stringify(results.UserId))
    //     await AsyncStorage.setItem('LoginToken', JSON.stringify(results.LoginToken))
    //     await AsyncStorage.setItem('ReturnCode', JSON.stringify(results.ReturnCode))
    //   } catch(e) {
    //     console.log(e);
    //   }
      // console.log(results);
      // console.log("set UserId: ", results.UserId);
      // console.log("set LoginToken : ", results.LoginToken);
      // console.log("set ReturnCode : ", results.ReturnCode);
      // console.log(results)
    // }

    // const CheckedUser = AuthUser();

    
  }

  return ( 
    <View style={styles.container}>
      <StatusBar backgroundColor="grey" barStyle="light-content" />
      <View style={styles.header}>
        <Animatable.Image
                  animation="bounceIn"
                  // duration="1500"
                  source={require('../assets/Logo_Orange.png')}
                  style={styles.logo}
                  resizeMode="stretch"
          />
      </View>
      
      <Animatable.View 
        animation="fadeInUpBig"
        style={styles.footer }
      >
        {/* id textbox */}
        <Text style={styles.text_footer}>아이디</Text>
        <View style={styles.action}>
          <FontAwesome 
            name="user-o"
            color="#f2aa4c"
            size={20}
          />
          <TextInput 
            placeholder="Your Username"
            placeholderTextColor="#f2aa4c"
            style={styles.textInput}
            autoCapitalize="none"
            onChangeText={(val) => setuserid(`${val}`)}
            onEndEditing={(e) => handleValidUser(e.nativeEvent.text)}
          />                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                               
          { data.check_textInputChange ? 
            <Animatable.View
              animation="bounceIn"
            >
              <FontAwesome 
                name="check-circle"
                color="green"
                size={20}
              />
            </Animatable.View>
          : null }
        </View>
       
        {/* style={styles.errorMsg} red */}


        {/* password textbox */}
        <Text style={[styles.text_footer, {marginTop: 35}]}>비밀번호</Text>
        <View style={styles.action}>
          <FontAwesome 
            name="lock"
            color="#f2aa4c"
            size={20}
          />
          <TextInput 
            placeholder="Your Password"
            placeholderTextColor="#f2aa4c"
            secureTextEntry={data.secureTextEntry ? true : false}
            style={styles.textInput} 
            autoCapitalize="none"
            onChangeText={(val) => setuserpwd(`${val}`)}
            onEndEditing={(e) => handlePasswordChange(e.nativeEvent.text)}
            //onChangeText={(val) => setuserpwd(`${handlePasswordChange(val)}`)}
          />
          <TouchableOpacity
            onPress={updateSecureTextEntry}
          >
            {data.secureTextEntry ?
            <FontAwesome 
              name="eye-slash"
              color="#f2aa4c"
              size={20}
            />
            :
            <FontAwesome 
              name="eye"
              color="#f2aa4c"
              size={20}
            />
            }           
          </TouchableOpacity>
        </View>

        <TouchableOpacity>
          <Text style={{color: '#f2aa4c', marginTop: 15}}>Forgot password</Text>
        </TouchableOpacity>

        <View style={styles.button}>


          {/* login button */}
          <TouchableOpacity
            style={styles.signIn}
            onPress={ () => {
              // if(recode === 0){
              //   //SignInScreen();
              //   loginHandle( data.username, data.password ) 
              // }else{
              //   Alert.alert(remessage)
              // }
              loginHandle( data.username, data.password )
            }}
            //onPress={ () => {loginHandle( data.username, data.password ) }}
          >
            <LinearGradient
              colors={['#f2aa1c', '#f2aa5c']}
              style={styles.signIn}
            >
              <Text style={[ styles.textSign, {color:'#101820'} ]}>로그인</Text>
            </LinearGradient>
          </TouchableOpacity>

        </View>

      </Animatable.View>
    </View>
  );
}

export default SignInScreen;

const styles = StyleSheet.create({ 
  container: {
      flex: 1,
      backgroundColor: '#101820',
  },
  header: {
      flex: 1,
      justifyContent: 'flex-end',
      paddingHorizontal: 20,
      paddingBottom: 50,
  },
  footer: {
      flex: 5,
      backgroundColor: '#101820',
      borderTopLeftRadius: 30,
      borderTopRightRadius: 30,
      borderTopWidth: 1,
      borderRightWidth: 1,
      borderLeftWidth: 1,
      borderColor: '#f2aa4c',
      paddingVertical: 50,
      paddingHorizontal: 30,
  },
  text_header: {
    color: '#f2aa4c',
    fontWeight: 'bold',
    fontSize: 30,
  },
  text_footer: {
      color: '#f2aa4c',
      fontWeight: 'bold',
      fontSize: 30,
  },
  action: {
      flexDirection: 'row',
      marginTop: 10,
      borderBottomWidth: 1,
      borderBottomColor: '#f2aa4c',
      paddingBottom: 5,
  },
  textInput: {
      flex: 1,
      marginTop: Platform.OS === 'ios' ? 0 : -12,
      paddingLeft: 10,
      color: '#f2aa4c',
  },
  button: {
      alignItems: 'center',
      marginTop: 50,
      
  },
  signIn: {
      width: '100%',
      height: 50,
      justifyContent: 'center',
      alignItems: 'center',
      borderRadius: 10,
      
  },
  textSign: {
      fontSize: 18,
      fontWeight: 'bold',
  },
  errorMsg: {
    color: 'red'
  },
  logo: {
    width: 200,
    height: 50,
},
});