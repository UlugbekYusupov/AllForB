import * as React from 'react';

import { createStackNavigator } from '@react-navigation/stack';

import SplashScreen from '../auth/splashScreen';
import SigninScreen from '../auth/signinScreen';
import SignupScreen from '../auth/signupScreen';

const Stack = createStackNavigator();

const RootStack = ({navigation}) => (
    <Stack.Navigator headerMode='none'>
        <Stack.Screen name="SplashScreen" component={SplashScreen} />
        <Stack.Screen name="SigninScreen" component={SigninScreen} />
        <Stack.Screen name="SignupScreen" component={SignupScreen} />
    </Stack.Navigator>
);

export default RootStack;

