import * as React from 'react';
import { StyleSheet, ScrollView, View, Text, Image } from 'react-native';
import Logo from '../assets/Logo_Orange.png'


const MainLogo = () => {
    return (
        <View style={ styles.logoView }>
            <Image source={Logo} style={ styles.logoStyle } />
        </View>
    );
};

export default MainLogo;

const styles = StyleSheet.create({
    logoView: {
       // width: 400,
        alignItems: 'center',
    },
    logoStyle: {
        width: '100%', 
        height: 90,
    },
})