import * as React from 'react';
import { StyleSheet, View, Text, Button, } from 'react-native';


const DetailsScreen = ({navigation}) => {
    return (
      <View style={styles.container}>
        <Text>Home Screen</Text>
        <Button 
          title="Go to details screen again"
          onPress={() => navigation.push("Details")}
        />
        <Button 
          title="Go to home"
          onPress={() => navigation.navigate("Home")}
        />
        <Button 
          title="Go back"
          onPress={() => navigation.goBack()}
        />
        <Button 
          title="Go to the first screen"
          onPress={() => navigation.popToTop()}
        />
      </View>
    );
  }

  export default DetailsScreen;

  const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
    },
});