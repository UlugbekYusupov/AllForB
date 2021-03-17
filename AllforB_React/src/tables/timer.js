import * as React from 'react';
// import { useEffect, useState } from 'react';
import { Text, View, StyleSheet } from 'react-native';
// import stylled from 'styled-components/native';
import moment from 'moment';
import 'moment/locale/ko'; 

// import "moment/locale/ko";

moment.locale("ko");

const timer = () => {

    const [ now, setNow ] = React.useState( moment() );

    React.useEffect( () => {
        setInterval( () => {
            setNow( moment() );
        }, 1000 );
    }, [] );

    return (
        <View style={{flexDirection: 'row' }}>
            <Text>{ now.format( 'HH') }</Text>
            <Text>:</Text>
            <Text>{ now.format( 'mm') }</Text>
            <Text>:</Text>
            <Text>{ now.format( 'ss') }</Text>
        </View>
    )
}

export default timer;