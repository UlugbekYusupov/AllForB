import React, { useEffect, useState } from 'react';
import { Button, Text, View, StyleSheet, Image, Container, TouchableOpacity } from 'react-native';
import { useNavigation, useRoute } from '@react-navigation/native';
// import MainHeaderMenu from '../headers/mainHeaderMenu';
import QR from '../assets/QR_sample1.png';
// import StateDropdown from '../components/stateDropdown';
import { TextInput } from 'react-native-paper';
import StateSelector, { value, label } from '../buttons/stateSelector';
import Time from '../tables/timer';
//import QRCode from 'react-native-qrcode-svg';
import QRCode from 'react-native-qr-generator';
import AsyncStorage from '@react-native-community/async-storage';
import Url from '../api/urlBase';
import { Alert } from 'react-native';
import SwitchSelector from "react-native-switch-selector";
import timer from '../tables/timer';
import DeviceInfo from 'react-native-device-info';
import LinearGradient from 'react-native-linear-gradient';

//import { getPhoneNumber } from 'react-native-device-info';
//import { white } from 'react-native-paper/lib/typescript/styles/colors';
// import MinCountdown from '../components/countdown';


const QrChecker = () => {

    const navigation = useNavigation();
    //const route = useRoute();

    const [qrcdata, setqrcdata] = useState();
    const [inoutType, setInoutType] = useState(3);
    const [Pnumber, setPnumber] = useState();
    // const [counter, setcounter] = useState(counter);
    const fetchQRCode = () => {
        DeviceInfo.getPhoneNumber().then((PhoneNumber) => {
            console.log(PhoneNumber)
            setPnumber(PhoneNumber)
        })
        setTimeout( async() => {
            // setIsLoading(false);
            let userid;
            //let companyid;
              userid = null;
              //companyid = null;
              try {
                userid = await AsyncStorage.getItem('UserId')
                //setuserid(userid = await AsyncStorage.getItem('UserId'))
                //companyid = await AsyncStorage.getItem('companyId')
              } catch(e) {
                console.log(e); 
              }
              console.log( 'get user id:', userid)
            //setuserid(userid)
            //console.log( 'get user companyid:', companyid );      
            //dispatch({ type: 'REGISTER', token: userToken });
            fetch(`${Url}/attendance/createQR`,{
                method: 'POST',
                headers: {
                    'Accept': 'application/json',
                    'Content-Type': 'application/json;charset=utf-8',    
                }
                ,
                body: JSON.stringify({
                    UserId: userid,
                    CompanyId: '1',
                    PhoneNo: '010-7742-8356',
                    InoutTypeId : inoutType
                })
                
            }) 
            .then((response) => response.json())
            .then((results) =>{
                console.log(results)
                console.log(results.ExpireDateTime)
                setqrcdata( results.InoutQRValue );
                //setInoutType(results.InoutTypeId)
                //setcounter( results.ExpireDateTime );
            })
            .catch((error) => {
                console.error(error)
            })
            }, 1000);

    //    fetch(`${Url}/attendance/createQR`,{
    //         method: 'POST',
    //         headers: {
    //             'Accept': 'application/json',
    //             'Content-Type': 'application/json;charset=utf-8',    
    //         }
    //         ,
    //         body: JSON.stringify({
    //             UserId: 1,
    //             CompanyId: 1,
    //             PhoneNo: '010-4086-8284',
    //             InoutTypeId : inoutType
    //         })
            
    //     }) 
    //     .then((response) => response.json())
    //     .then((results) =>{
    //         console.log(results)
    //         console.log(results.ExpireDateTime)
    //         setqrcdata( results.InoutQRValue );
    //         //setInoutType(results.InoutTypeId)
    //         //setcounter( results.ExpireDateTime );
    //     })
    //     .catch((error) => {
    //         console.error(error)
    //     })
        
    }

    useEffect(()=>
        {
            fetchQRCode();
        }, [inoutType]
    );
    const [minutes, setMinutes] = useState(parseInt(5));
    const [seconds, setSeconds] = useState(parseInt(5));
    //const [timecreate, settimecreate] = useState();
    const reset = () => {
        setMinutes(5)
        setSeconds(0)
    }
    // fetchQRCode();
    // if(inoutType === 3){
    //     fetchQRCode();
    // }if(inoutType === 4){
    //     fetchQRCode();
    // }else{
    //     fetchQRCode();
    // }

    const TimeChecker = () => {
        if(QrChecker){
            Alert.alert('인증시간이 초과되었습니다.')
            setqrcdata('-')
            
        } else {
            
        }
    }

    useEffect(() => {

            const countdown = setInterval(() => {
                if ((seconds) > 0) {
                  setSeconds((seconds) - 1);
                }
                if ((seconds) === 0) {
                  if ((minutes) === 0) {
                    TimeChecker();
                    //fetchQRCode();
                    clearInterval(countdown);
                    //setMinutes(5)
                  } else {
                    setMinutes((minutes) - 1);
                    setSeconds(59);
                  }
                }
              }, 1000);
              
              return () => clearInterval(countdown);  
              
    },[seconds, minutes]);
    

  return (
    <View style={{backgroundColor: '#101820', width: '100%', height: '100%'}}> 

        <View style={styles.qrView}>
            <QRCode
                size={300}
                backgroundColor={'#101820'}
                foregroundColor={'#ffffff'}
                value={qrcdata}
            />
            {/* <Text style={{color: 'white'}}>{Pnumber}</Text> */}
            {/* <Text style={{color: 'white'}}>{inoutType}</Text> */}
        </View>  
        {/* <StateSelector />         */}
        <SwitchSelector
            style={styles.selector}
            initial={0}
            onPress={value => setInoutType(`${value}`)}
            buttonColor={'#F2AA4C'} 
            textColor={'#101820'}
            selectedColor={'#101820'}
            backgroundColor={'#c4c9cf'}
            fontSize={25}
        //     hasPadding
            options={[
                { label: "출근", value: "3",}, 
                { label: "퇴근", value: "4" }   
            ]}   
            />

        <View style={{flexDirection: 'row', alignSelf: 'center', marginTop: 30, borderColor: '#F2AA4C', borderWidth: 1, backgroundColor: '#101820'}}>
            <Text style={{marginTop: 2, paddingRight: 10,paddingLeft: 10, color: '#F2AA4C',fontSize: 20}}>인증시간</Text>
            <Text style={{color: 'white', paddingRight: 10, paddingLeft: 10, fontSize: 20,borderLeftColor:'#f2aa4c', borderLeftWidth: 1}}>{minutes}:{seconds < 10 ? `0${seconds}` : seconds}</Text>
        </View>


        <TouchableOpacity
            style={styles.refreshButton}
            onPress={ () => {
                if(minutes === 0 && seconds === 0){
                    fetchQRCode();
                    setMinutes(5)
                    setSeconds(5)
                }else{
                    setMinutes(0)
                    setSeconds(0)
                }
              // if(recode === 0){
              //   //SignInScreen();
              //   loginHandle( data.username, data.password ) 
              // }else{
              // }
              //loginHandle( data.username, data.password )
            }}
            //onPress={ () => {loginHandle( data.username, data.password ) }}
          >
            <LinearGradient
              colors={['#f2aa1c', '#f2aa5c']}
              style={styles.qrbutton}
            >
                <Text style={{color:'#101820', textAlign: 'center',fontSize: 18,}}>QR Code 재생성</Text>
            </LinearGradient>
          </TouchableOpacity>
          {/* <TouchableOpacity
            style={styles.refreshButton}
            onPress={ () => {
                if(minutes === 0){
                    fetchQRCode();
                    setMinutes(5)
                }else{
                    Alert.alert('')
                }
              // if(recode === 0){
              //   //SignInScreen();
              //   loginHandle( data.username, data.password ) 
              // }else{
              // }
              //loginHandle( data.username, data.password )
            }}
            //onPress={ () => {loginHandle( data.username, data.password ) }}
          >
            <LinearGradient
              colors={['#f2aa1c', '#f2aa5c']}
              style={styles.signIn}
            >
                <Text style={{color:'#101820', textAlign: 'center',fontSize: 18, fontWeight: 'bold'}}>QR STOP</Text>
            </LinearGradient>
          </TouchableOpacity> */}
        {/* <View style={styles.refreshButton} >
            <Button color='#F2AA4C'
            //style={{color: '#101820'}}
                title="QR Code 재생성"          
                onPress={
                    fetchQRCode,
                    setMinutes(5)
                }
            >
            </Button>
        </View> */}
        {/* <View style={styles.refreshButton2} >
            <Button color='#F2AA4C'
            //style={{color: '#101820'}}
                title="인증시간 재생성"          
                onPress={reset}
            >
            </Button>
        </View> */}

    </View>
    
  )
}

const styles = StyleSheet.create({
    // headerView: {
    //     backgroundColor: 'blue',
    // },
    // pageView: {
    //     backgroundColor: 'blue',
    // },
    pageText: {
        alignSelf: 'center', color: 'white', paddingBottom: 2,  fontSize: 15, 
    },

    titleView: {
        backgroundColor:'orange', 
        alignItems: 'center', 
        justifyContent: 'center', 
        height: 70, 
        borderRadius:30, 
        marginTop: 30, 
        marginRight: 80, 
        marginLeft: 80
    },

    titleText: {
        fontSize:25,
    },

    qrView: {
        alignItems: 'center',
        justifyContent: 'center',
        marginTop: 70,
        marginBottom: 20,
        height: 200,
    },

    qrStyle: {
        width: 250, 
        height: 250,  
        marginTop: 30,
    },

    refreshButton: {
        //backgroundColor: "blue",
        width: '50%',
        height: 50,
        alignSelf: 'center',
        justifyContent: 'center',
        alignContent: 'center',
        //color: "#101820",
        //textAlign: 'center',
        //fontWeight: 'bold',
        borderWidth: 1,
        borderRadius: 10,
        marginTop: 30,
        //backgroundColor: "#F2AA4C",
        
    },

    refreshButton2: {
        //backgroundColor: "blue",
        width: '50%',
        alignSelf: 'center',
        //color: "#101820",
        //fontWeight: 'bold',
        borderWidth: 1,
        borderRadius: 10,
        marginTop: 40,
        //backgroundColor: "#F2AA4C",
        
    },

    selector: {
        alignSelf: 'center',
        width: '70%',
        paddingHorizontal: 10,
        paddingTop: 20,
    },
    qrbutton: {
        width: '100%',
        height: 40,
        justifyContent: 'center',
        alignItems: 'center',
        borderRadius: 10,
    },

  });

export default QrChecker;