import * as React from 'react';
import { StyleSheet, View, Text, TouchableOpacity } from 'react-native';
import { useNavigation } from '@react-navigation/core';
import Ionicons from 'react-native-vector-icons/dist//Ionicons';
import MaterialIcons from 'react-native-vector-icons/dist/MaterialIcons';


const MenuButton = () => {
    const navigation = useNavigation();
    const openMenu = () => {
        navigation.openDrawer();
    };

    return (  
        <TouchableOpacity>
            <MaterialIcons name="menu" onPress={openMenu} 
                style={{ fontSize: 30, marginLeft: 10, marginTop: 5, paddingLeft: 5, paddingRight: 5, color:'#F2AA4C'}} 
            /> 
        </TouchableOpacity>
    );
};

export default MenuButton;