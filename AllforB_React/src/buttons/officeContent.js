import * as React from 'react';
import { StyleSheet, ScrollView, View, Button, Image } from 'react-native';
import { DrawerContentScrollView, DrawerItem } from '@react-navigation/drawer';
import { Avatar, Title, Caption, Paragraph, Drawer, Text, TouchableRipple, Switch } from 'react-native-paper';
import Ionicons from 'react-native-vector-icons/dist/Ionicons';
import FontAwesome from 'react-native-vector-icons/FontAwesome';
import { AuthContext } from '../contexts/context';
import { ProfileSidemenu, } from '../components/profileSidemenu';
import SignoutButton from '../buttons/signoutButton';

export function OfficeContent( props ) {

    const [isDarkTheme, setIsDarkTheme] = React.useState(false);

    // const { signOut } = React.useContext(AuthContext)

    const toggleTheme = () => {
        setIsDarkTheme(!isDarkTheme)
    }

    return (
        <View style={{ flex: 1, backgroundColor: '#101820',}}>
            <DrawerContentScrollView {...props}>
                <View style={styles.drawerContent}>
                    <View style={styles.userInfoSection}>
                        <ProfileSidemenu />
                        {/* <FollowSidemenu /> */}
                        {/* <View>
                            <Avatar.Image 
                                source={{ uri: 'https://wwww.facebook.com/photo?fbid=10213387117619620&set=a.1550512369959' }} 
                                size={50}
                            />
                            <View style={{ marginLeft: 15, flexDirection: 'column' }}>
                                <Title style={styles.title}>IGJAE SO</Title>
                                <Caption style={styles.caption}>@itzpradip</Caption>
                            </View>
                        </View> */}
                        {/* <View style={styles.row}>
                            <View>
                                <Paragraph style={[styles.paragraph, styles.caption]}>80</Paragraph>
                                <Caption style={styles.caption}>Following</Caption>
                                <Paragraph>100</Paragraph>
                                <Caption>Follower</Caption>
                            </View>
                        </View> */}
                    </View>
                    <Drawer.Section style={styles.drawerSection}>
                        <DrawerItem 
                            icon={({color, size}) => (
                                <Ionicons
                                    name="home"
                                    color={'#F2AA4C'}
                                    size={size}
                                />
                            )}
                            label="홈" 
                            labelStyle={{color: '#F2AA4c'}}
                            onPress={() => {props.navigation.navigate('HomeDrawer')}}        
                        />
                        <DrawerItem 
                            icon={({color, size}) => (
                                <FontAwesome
                                    name="address-book-o"
                                    color={'#F2AA4C'}
                                    size={size}
                                />
                            )}
                            label="프로필" 
                            labelStyle={{color: '#F2AA4c'}}
                            onPress={() => {props.navigation.navigate('ProfilesDrawer')}}        
                        />
                        <DrawerItem 
                            icon={({color, size}) => (
                                <FontAwesome
                                    name="wpforms"
                                    color={'#F2AA4C'}
                                    size={size}
                                />
                            )}
                            label="근무일정" 
                            labelStyle={{color: '#F2AA4c'}}
                            onPress={() => {props.navigation.navigate('RecorderDrawer')}}        
                        />
                        <DrawerItem 
                            icon={({color, size}) => (
                                <Ionicons
                                    name="qr-code-sharp"
                                    color={'#F2AA4C'}
                                    size={size}
                                />
                            )}
                            label="출퇴근 인증" 
                            labelStyle={{color: '#F2AA4c'}}
                            onPress={() => {props.navigation.navigate('CheckerDrawer')}}        
                        />
                        <DrawerItem 
                            icon={({color, size}) => (
                                <Ionicons
                                    name="settings"
                                    color={'#F2AA4C'}
                                    size={size}
                                />
                            )}
                            
                            label="설정" 
                            labelStyle={{color: '#F2AA4c'}}
                            onPress={() => {props.navigation.navigate('SettingsDrawer')}}        
                        />

                    </Drawer.Section>
                    <Drawer.Section  >
                        <Title style={styles.title}>관리자설정</Title>
                        <DrawerItem
                            icon={({color, size}) => (
                                <Ionicons
                                    name="qr-code-sharp"
                                    color={'#F2AA4C'}
                                    size={size}
                                />
                            )}
                            label="QR 스캔"
                            labelStyle={{color: '#F2AA4C'}}
                            onPress = {() => {props.navigation.navigate('QrDrawer')}}
                        />
                        {/* <TouchableRipple onPress={() => {toggleTheme()}}>
                            <View style={styles.perference}>
                                <Text style={{color: '#F2AA4C'}}>Dark Theme</Text>
                                <View pointerEvents="none">
                                    <Switch value={isDarkTheme} />
                                </View>
                            </View>
                        </TouchableRipple> */}
                    </Drawer.Section>
                </View>
            </DrawerContentScrollView>
            <SignoutButton />
            {/* <Drawer.Section style={styles.bottomDrawerSection}>
                <DrawerItem 
                    icon={({color, size}) => (
                        <Ionicons
                            name="log-out-outline"
                            color={color}
                            size={size}
                        />
                    )}
                    label="Sign Out" 
                    onPress={() => {signOut()}}        
                />
            </Drawer.Section> */}
        </View>
    );
}  

const styles = StyleSheet.create({
    drawerContent: {
        flex: 1,
        //backgroundColor: '#101820',
        
    },
    userInfoSection: {
        paddingLeft: 20,
        
    },
    title: {
        fontSize: 16,
        marginTop: 3,
        fontWeight: 'bold',
        color: '#F2AA4C',
        marginLeft: 90
    },
    caption: {
        fontSize: 14,
        lineHeight: 14,
        
    },
    row: {
        marginTop: 20,
        flexDirection: 'row',
        alignItems: 'center',
        
    },
    section: {
        flexDirection: 'row',
        alignItems: 'center',
        marginRight: 15,
        
    },
    paragraph: {
        fontWeight: 'bold',
        marginRight: 3,
    },
    drawerSection: {
        marginTop: 15,
        borderBottomWidth: 1,
        borderBottomColor: '#F2AA4C',
        borderTopWidth: 1,
        borderTopColor: '#F2AA4C',
        
    },
    bottomDrawerSection: {
        marginBottom: 15,
        borderTopColor: '#f4f4f4',
        borderTopWidth: 1,
    },
    perference: {
        flexDirection: 'row',
        justifyContent: 'space-between',
        paddingVertical: 12,
        paddingHorizontal: 16,
    },
})