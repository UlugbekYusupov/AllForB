import * as React from 'react';
import { StyleSheet, Image, View, Text, Button, Dimensions, TouchableOpacity } from 'react-native';
import LinearGradient from 'react-native-linear-gradient';
import MaterialIcons from 'react-native-vector-icons/MaterialIcons';
import * as Animatable from 'react-native-animatable';


const SplashScreen = ({navigation}) => {
  return (
    <View style={styles.container}>
        <View style={styles.header}>
            <Animatable.Image
                animation="bounceIn"
                // duration="1500"
                source={require('../assets/Logo_Orange.png')}
                style={styles.logo}
                resizeMode="stretch"
            />
           
        </View>
        <Animatable.View 
            style={styles.footer}
            animation="fadeInUpBig"
        >
            <Text style={styles.title}>Stay connected with everyone!</Text>
            <Text style={styles.text}>Sign in with account</Text>
            <View style={styles.button}>
                <TouchableOpacity onPress={ () => navigation.navigate('SigninScreen') }>
                    <LinearGradient
                        colors={['#f2aa1c', '#f2aa5c']}
                        style={styles.signIn}
                    >
                        <Text style={styles.textSign}>로그인 페이지</Text>
                        <MaterialIcons 
                            name="navigate-next"
                            color="#101820"
                            size={20}
                        />
                    </LinearGradient>
                </TouchableOpacity>
            </View>      
        </Animatable.View>  
    </View>
  );
}

export default SplashScreen;

const {height} = Dimensions.get("screen")
const height_logo = height * 0.28;

const styles = StyleSheet.create({ 
    container: {
        flex: 1,
        backgroundColor: '#101820',
    },
    header: {
        flex: 2,
        justifyContent: 'center',
        alignItems: 'center',
    },
    footer: {
        flex: 1,
        backgroundColor: '#101820',
        borderTopLeftRadius: 30,
        borderTopRightRadius: 30,
        paddingVertical: 50,
        paddingHorizontal: 30,
        borderColor: '#f2aa4c',
        borderTopWidth: 1,
        borderLeftWidth: 1,
        borderRightWidth: 1,
    },
    logo: {
        width: 350,
        height: 100,
    },
    title: {
        color: '#F2AA4C',
        fontSize: 30,
        fontWeight: 'bold',
        // textAlign: 'center',
    },
    text: {
        color: '#f2aa4c',
        marginTop: 5,
        // textAlign: 'center',
    },
    button: {
        alignItems: 'flex-end',
        marginTop: 30,
    },
    signIn: {
        width: 150,
        height: 40,
        justifyContent: 'center',
        alignItems: 'center',
        borderRadius: 50,
        flexDirection: 'row',
    },
    textSign: {
        color: '#101820',
        fontWeight: 'bold',
    },
});
