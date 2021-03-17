import React, { useEffect, useState, useRef, Component } from 'react';
import { Button, Text, View, StyleSheet, Image, Container, Linking, TouchableOpacity, Alert } from 'react-native';
import { Link, useNavigation, useRoute } from '@react-navigation/native';
// import MainHeaderMenu from '../headers/mainHeaderMenu';
//import QR from '../assets/QR_sample1.png';
import QRCodeScanner from 'react-native-qrcode-scanner';
// import StateDropdown from '../components/stateDropdown';
import { TextInput } from 'react-native-paper';
import StateSelector, { value, label } from '../buttons/stateSelector';
import Time from '../tables/timer';
import AsyncStorage from '@react-native-community/async-storage';
import Url from '../api/urlBase';
import Toast from 'react-native-simple-toast';
//import { white } from 'react-native-paper/lib/typescript/styles/colors';
// import MinCountdown from '../components/countdown';



const StateChecker = (props) => {

    //const qdata = e.data

    // fetch(`${Url}/api/attendance/checkQR`,{
    //     method: 'POST',
    //     headers: {
    //         'Accept': 'application/json',
    //         'Content-Type': 'application/json;charset=utf-8',    
    //     }
    //     ,
    //     body: JSON.stringify({
    //         UserId: 1,
    //         CompanyId: 1,
    //         QRCode: "",
    //     })
    // })
    // .then((response) => response.json())
    // .then((results) =>{
    //     SetQrdata(results)
    // })
    // .catch((error) => {console.error("error")})
    



    // const SetQrdata = async (results) => {
    //     try {
    //         await AsyncStorage.setItem('ResultCode', JSON.stringify(results.ResultCode))
    //     }catch(e){
    //         console.log(e);
    //     }
    //     console.log("ResultCode: ", results.QRCode);
    //     console.log(results)
    // }

    // useEffect( () => {
    //     setTimeout( async() => {
    //       // setIsLoading(false);
    //       let qrcode;
    //         qrcode = null;
    //         try {
    //           qrcode = await AsyncStorage.getItem('QRCode')
    //         } catch(e) {
    //           console.log(e); 
    //         }
    //       console.log('qrdata:',qrcode)   
    //     }, 1000);
    //   }, []);

    // const [scan, setScan] = useState(false);
    // const [scanResult, setScanResult] = useState(false);
    // const [result, setResult] = useState(null);

    // const scanner = React.useRef('');

    // onSuccess = e=>{
    //     //const check = e.data.substring(0, 4);
    //     console.log('scanned data' + check);

    //     setResult(e);
    //     setScan(false);
    //     setScanResult(true);

    //     if (check === 'https') {
    //         Linking
    //             .openURL(e.data)
    //             .catch(err => Alert('An error occured', err));
    //     }else {
    //         setResult(e);
    //         setScan(false);
    //         setScanResult(true);
    //     }
    // };
    
    // const activeQR = () => {
    //     setScan(true)
    // }

    // const scanAgain = () => {
    //     setScan(true);
    //     setScanResult(false);
    // };

    // const desccription = 'QR code (abbreviated from Quick Response Code) is the trademark for a type'


    // const navigation = useNavigation();
    // const route = useRoute();
    
    // useEffect(() => {

    // }, []);

    // const UserId = await AsyncStorage.getItem('UserId')
    // const CompanyId = await AsyncStorage.getItem('CompanyId')

    const scanner = useRef(null);
    const [scan, setScan] = useState(false);
    const [result, setResult] = useState(null);

    useEffect(() => {
        setTimeout( async() => {
            // setIsLoading(false);
            let userid;
            let companyid;
              userid = null;
              companyid = null;
              try {
                userid = await AsyncStorage.getItem('UserId')
                companyid = await AsyncStorage.getItem('companyId')
              } catch(e) {
                console.log(e); 
              }
            console.log( 'get user id:', userid)
            console.log( 'get user companyid:', companyid );      
            //dispatch({ type: 'REGISTER', token: userToken });
          }, 1000);
        // setResult(null);
        // ifScaned();
        // let UserId;
        // let CompanyId;
        // try{
        // const UserId = await AsyncStorage.getItem('UserId')
        // const CompanyId = await AsyncStorage.getItem('CompanyId')
        // }catch(e){
        //     console.log(e);
        // }
        // setTimeout(console.log('sadasdaasd'), 10000);
    }, [])

    const ifScaned= (e)=>{

        setTimeout( async() => {
            // setIsLoading(false);
            let userid;
            //let companyid;
              userid = null;
              //companyid = null;
              try {
                userid = await AsyncStorage.getItem('UserId')
                //companyid = await AsyncStorage.getItem('companyId')
              } catch(e) {
                console.log(e); 
              }
            console.log( 'get user id:', userid)
            //console.log( 'get user companyid:', companyid );    

        setResult(e);
        setScan(false);
    
        const QRC = e.data;
        console.log(e.data)
        fetch(`${Url}/attendance/checkQR`,{
            method: 'POST',
            headers: {
                'Accept': 'application/json',
                'Content-Type': 'application/json;charset=utf-8',    
            }
            ,
            body: JSON.stringify({
                //UserId: UserId,
                //CompanyId: CompanyId,
                UserId: userid,
                CompanyId: '1',
                QRCode: QRC,
            })
        })
        
        .then((response) => response.json())
        .then((result) =>{
        //     // SetQrdata()
            console.log(result)
            // console.log(res.body.QRCode)
            // console.log( result.ExceptionMessage )
            //Alert.alert('인증 완료', result.ExceptionMessage)
            //Alert.alert(result.isOK)
            if(result.ReturnCode === 0){
                //Alert.alert('인증되었습니다.')
                Toast.show('인증되었습니다')
                
            }else{
                //Alert.alert(result.ExceptionMessage)
                Toast.show(result.ExceptionMessage)
            }
        })
        .catch((error) => {
            console.error(error)
            Alert.alert(result.ExceptionMessage)
        })
      }, 1000);
    }

    return (
     <View style={{backgroundColor: '#101820', height: '100%'}}> 
        <QRCodeScanner
            containerStyle={{backgroundColor: '#101820',}}
            onRead={ifScaned}
            reactivate={true}
            permissionDialogMessage="Need Permission To Access Camera"
            reactivateTimeout={10000}
            showMarker={true}
            cameraType={'front'}
            markerStyle={{borderColor:'#fff', borderRadius: 10}}
        />
        
        {/* <Time 
            style={{color: '#fff'}}
        /> */}
        
        {/* <View style={styles.headerView}>
            <MainHeaderMenu />
        </View> */}

        {/* QR code 이미지 */}
        {/* <View style={styles.qrView}>
            <Image source={QR} style={styles.qrStyle} />
        </View>   

        <StateSelector />        

        <View style={{flexDirection: 'row', alignSelf: 'center', marginTop: 20, borderColor: '#F2AA4C', borderWidth: 1, backgroundColor: '#101820'}}>
            <Text style={{marginTop: 5, paddingRight: 10,paddingLeft: 10, color: '#F2AA4C',}}>인증시간</Text>
            <TextInput style={{width: 50, height: 30, backgroundColor: '#a2a2a3',borderColor:'#fff', borderWidth: 1,}} />
        </View>

        <View style={styles.refreshButton} >
            <Button color='#F2AA4C'
            //style={{color: '#101820'}}
                title="QR Code 재생성"          
                
                onPress={() => {
                    navigation.navigate('Profiles')
                }}
            >
            <Text style={{color: '#101820'}}>1111</Text>
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
    },

    qrStyle: {
        width: 250, 
        height: 250,  
        marginTop: 30,
        
    },

    refreshButton: {
        //backgroundColor: "blue",
        width: '50%',
        alignSelf: 'center',
        //color: "#101820",
        //fontWeight: 'bold',
        borderWidth: 1,
        borderRadius: 10,
        marginTop: 20,
        //backgroundColor: "#F2AA4C",
        
    },

  });

export default StateChecker;