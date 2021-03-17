import * as React from 'react';
import { StyleSheet, ScrollView, View, Text, } from 'react-native';
import { createStackNavigator } from '@react-navigation/stack';
import RecorderScreen from '../screens/recorderScreen';
import CheckerScreen from '../screens/checkerScreen';
import qrScreen from '../screens/qrScreen';
import Menu from '../buttons/menu';

const Recorder_Stack = createStackNavigator();
export const RecorderStack = ({ navigation }) => {
    
    return (
        <Recorder_Stack.Navigator
          screenOptions={{
            headerStyle:{
            backgroundColor: '#101820',
            borderBottomColor: '#F2AA4C',
            borderBottomWidth: 1
            
          },
            headerTintColor: '#F2AA4C',
            headerTitleStyle: {
              fontWeight: 'bold',
              fontSize: 25,
            }
          }}
        >
          <Recorder_Stack.Screen 
            name="RecorderStack" 
            component={RecorderScreen} 
            options={{
              
              title: '근무일정',
              headerTitleAlign: 'center',
               //headerShown: false,
              headerLeft: () => (<Menu />)
            }}
          />
        </Recorder_Stack.Navigator>
    );
};

const Checker_Stack = createStackNavigator();
export const CheckerStack = ({ navigation }) => {
    
    return (
        <Checker_Stack.Navigator
          screenOptions={{
            headerStyle:{
            backgroundColor: '#101820',
            borderBottomColor: '#F2AA4C',
            borderBottomWidth: 1
          },
          headerTintColor: '#F2AA4C',
            headerTitleStyle: {
              fontWeight: 'bold',
              fontSize: 25,
            }
          }}
        >
          <Checker_Stack.Screen 
            name="CheckerStack"
            component={CheckerScreen} 
            options={{
              title: 'QR 스캔',
              headerTitleAlign: 'center',
              // headerShown: false,
              headerLeft: () => (<Menu />)
            }}
          />
        </Checker_Stack.Navigator>
    );
};

const Qr_Stack = createStackNavigator();
export const QrStack = ({ navigation }) => {
    
    return (
        <Qr_Stack.Navigator
          screenOptions={{
            headerStyle:{
            backgroundColor: '#101820',
            borderBottomColor: '#F2AA4C',
            borderBottomWidth: 1
          },
          headerTintColor: '#F2AA4C',
            headerTitleStyle: {
              fontWeight: 'bold',
              fontSize: 25,
            }
          }}
        >
          <Checker_Stack.Screen 
            name="QrStack"
            component={qrScreen} 
            options={{
              title: 'QR 생성',
              headerTitleAlign: 'center',
              // headerShown: false,
              headerLeft: () => (<Menu />)
            }}
          />
        </Qr_Stack.Navigator>
    );
};

// export { CheckerStack, RecorderStack };