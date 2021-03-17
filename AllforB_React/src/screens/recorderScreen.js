import React, { useState, useEffect } from 'react';
import { Button, Text, View, StyleSheet, ScrollView, TouchableOpacity, Image } from 'react-native';
import { useNavigation, useRoute } from '@react-navigation/native';
// import MainHeader from '../headers/mainHeaderMenu';
import StateSelector from '../buttons/stateSelector';
import RecordTable from '../tables/recorderTable';
import {Calendar} from 'react-native-calendars';
import 'moment/locale/ko';
import moment from 'moment-timezone';
// import HistoryTable from '../tables/historyTable';
// import Timer from '../tables/timer';


const Recorder = () => {

  const navigation = useNavigation();
//   const route = useRoute();


  return (
    <View style={{backgroundColor: '#101820', width: '100%', height: '100%'}}>
        <View>
        <Calendar 

            onDayPress={(response) => console.log(response)}
            current={moment().tz("Asia/Seoul").format()} 

            // markedDates={{
            //     '2021-01-01': {selected: true, marked: true, selectedColor: '#F2AA4C'},
            //     '2021-01-25': {marked: true},
            //     '2021-01-21': {marked: true, dotColor: 'red', activeOpacity: 0},
            // }}

            // current={<Time/>}
            // minDate={'2021-01-01'}
            // maxDate={'2021-12-31'}

            // onDayPress={(day) => {console.log('selected day', day)}}
            // onDayLongPress={(day) => {console.log('selected day', day)}}

            // monthFormat={'yyyy MM'}
            // onMonthChange={(month) => {console.log('month changed', month)}}
            // hideArrows={false}
            // //renderArrow={(direction) => (<Arrow/>)}
            // hideExtraDays={false}
            // disableMonthChange={true}
            // firstDay={1}
            // hideDayNames={false}
            // showWeekNumbers={false}
            // onPressArrowLeft={substractMonth => substractMonth()}
            // onPressArrowRight={addMonth => addMonth()}
            // disableArrowLeft={false}
            // disableArrowRight={false}
            // disableAllTouchEventsForDisabledDays={true}

            style = {{
                borderWidth: 1,
                borderColor: '#F2AA4C',
                //borderRadius: 20,
                marginTop: 10,
                
            }}
            theme = {{
                backgroundColor : '#101820',
                calendarBackground: '#101820',
                textSectionTitleColor: '#F2AA4C', 
                dayTextColor: '#F2AA4C',
                todayTextColor: 'blue',
                textDisabledColor: '#969696',
                arrowColor: '#F2AA4C',
                monthTextColor: '#F2AA4C',
                textMonthFontWeight: 'bold',
                textMonthFontSize : 16,
            }}
            />
            {/* <CalendarList
            horizontal = {true}
            pagingEnabled = {true}
            calendarWidth = {300}

            /> */}
        </View>
        {/* <View style={styles.headerView}>
            <MainHeader />       
        </View> */}

        {/* <View style={styles.pageView}>
            <Text style={styles.pageText}>출퇴근 테스트</Text>
        </View> */}

        {/* <View>
            <Timer />
        </View> */}

        {/* <Text
            style={styles.topButton}
            onPress={() => {
                navigation.navigate('Signin')
            }}
        >
            출퇴근 생성
        </Text> */}

        

        

        <View style={styles.tableView}>
            {/* <View style={styles.titleView}>
                <Text style={styles.titleLeftText}>인중일시</Text>
                <Text style={styles.titleRightText}>출퇴근 구분</Text>
            </View> */}
                <RecordTable />
                {/* <HistoryTable /> */}
           
        </View>

    </View>
  )
}

const styles = StyleSheet.create({
    headerView: {
        backgroundColor: 'blue',
    },
    pageView: {
        backgroundColor: 'blue',
    },
    pageText: {
        alignSelf: 'center', color: 'white', paddingBottom: 2,  fontSize: 15, 
    },
    topButton: {
        marginTop: 15,
        alignSelf: 'center',
        borderWidth: 1,
        borderRadius: 10,
        paddingTop:5,
        paddingBottom: 0,
        paddingLeft: 50,
        paddingRight: 50,
        fontSize: 30,
        fontWeight: 'bold',
        backgroundColor: "#F2AA4C",
        color: '#101820',
        justifyContent: 'center',
    },  
    subTitle: {
        backgroundColor: '#F2AA4C',
        alignItems: 'center',
        alignSelf: 'center',
        marginTop: 20,
        // marginBottom: 5,
        width: '60%',
        borderWidth: 1,
        borderRadius: 10,
        color: '#101820',
    },
    selector: {
        alignSelf: 'center',
        width: '70%',
        paddingHorizontal: 10,
        paddingTop: 10,
    },

    iconStyle: {
        alignSelf: 'flex-start',
        width: 35, 
        height: 30,  
        marginTop: 20, 
        marginLeft: 10, 
        // color: 'white',
    },
    directionView: {
        flexDirection: 'row',
    },



    tableView: {
        alignSelf: 'center',
        width: '80%',
        height: 200,
        marginTop: 10
       // paddingTop: 10,
    },

    titleView: {
        flexDirection: 'row',
        alignSelf: 'center',
    },

    titleLeftText: {
        textAlign: 'center',
        fontSize: 15,
        fontWeight: "bold",
        borderColor: 'green',
        borderWidth: 1,
        width: '65%',
    },
    titleRightText: {
        textAlign: 'center',
        fontSize: 15,
        fontWeight: "bold",
        borderColor: 'green',
        borderWidth: 1,
        width: '35%',
    },

    scrollContainer: {
        //borderWidth: 1,
        
    },

    // listView: {
    //     flexDirection: 'row',
    //     alignSelf: 'center',
    // },

    // listLeftText: {
    //     textAlign: 'center',
    //     fontSize: 15,
    //     fontWeight: "bold",
    //     borderColor: 'blue',
    //     borderWidth: 1,
    //     width: '65%',
    // },
    // listRightText: {
    //     textAlign: 'center',
    //     fontSize: 15,
    //     fontWeight: "bold",
    //     borderColor: 'blue',
    //     borderWidth: 1,
    //     width: '35%',
    // },



  });

export default Recorder;