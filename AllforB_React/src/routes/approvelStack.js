import * as React from 'react';
import { StyleSheet, ScrollView, View, Text, } from 'react-native';
import { createStackNavigator } from '@react-navigation/stack';
import ApprovelScreen1 from '../screens/approvelScreen1';
import ApprovelScreen2 from '../screens/approvelScreen2';
import Menu from '../buttons/menu';


const Approvel_Stack1 = createStackNavigator();
export const ApprovelStack1 = ({ navigation }) => {
    
    return (
        <Approvel_Stack1.Navigator
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
            <Approvel_Stack1.Screen 
              name="CheckerStack" 
              component={ApprovelScreen1} 
              options={{
                title: '전자결재 1',
                headerTitleAlign: 'center',
                // headerShown: false,
                headerLeft: () => (<Menu />)
              }}
            />
        </Approvel_Stack1.Navigator>
    );
};


const Approvel_Stack2 = createStackNavigator();
export const ApprovelStack2 = ({ navigation }) => {
    
    return (
        <Approvel_Stack2.Navigator
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
          <Approvel_Stack2.Screen 
            name="RecorderStack" 
            component={ApprovelScreen2} 
            options={{
              title: '전자결재 2',
              headerTitleAlign: 'center',
              // headerShown: false,
              headerLeft: () => (<Menu />)
            }}
          />
        </Approvel_Stack2.Navigator>
    );
};

// export { ApprovelStack1, ApprovelStack2 };