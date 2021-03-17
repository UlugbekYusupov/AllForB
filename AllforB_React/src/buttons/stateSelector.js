import React from 'react';
import { Text, View, StyleSheet, Image, TouchableOpacity } from 'react-native';
import { colors } from 'react-native-elements';
import SwitchSelector from "react-native-switch-selector";


// const officerOptions = [
//     { label: '출근', value: 'arrive' },
//     { label: '퇴근', value: 'leave' },
// ];  

const StateSelector = () => {
    return (

        <SwitchSelector
            style={styles.selector}
            initial={0}
            onPress={value => setInoutType(`${value}`)}
            buttonColor={'#F2AA4C'} 
            textColor={'#101820'}
            selectedColor={'#101820'}
            backgroundColor={'#c4c9cf'}
            fontSize={25}     
            options={[
                { label: "출근", value: "3",}, 
                { label: "퇴근", value: "4" }   
            ]}   
            />

        // , imageIcon: images.feminino   images.feminino = require('./path_to/assets/img/feminino.png')
        // , imageIcon: images.masculino    images.masculino = require('./path_to/assets/img/masculino.png')

        // <View>
        //     <SwitchSelector
        //         style={styles.selector}
        //         textColor="red"
        //         fontSize={28}
        //         selectedColor="blue"
        //         buttonColor="green"C:\Users\SangYun\Desktop\asdsa\Navigation5_Login
        //         borderColor="black"
        //         hasPadding
        //         options={officerOptions}
        //         initial={0}
        //         onPress={value => console.log(`Call onPress with value: ${value}`)}
        //     /> 
        // </View>
    );
}

const styles = StyleSheet.create({
    selector: {
        alignSelf: 'center',
        width: '70%',
        paddingHorizontal: 10,
        paddingTop: 20,
    }
})

export default StateSelector;