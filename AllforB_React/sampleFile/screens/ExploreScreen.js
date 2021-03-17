import * as React from 'react';
import { StyleSheet, View, Text, Button, } from 'react-native';


const ExploreScreen = ({navigation}) => {
  return (
    <View style={styles.container}>
      <Text>Explore Screen </Text>
      <Button  
        title="click Here"
        onPress={() => alert('Button Clicked!')}
      />
    </View>
  );
}

export default ExploreScreen;

const styles = StyleSheet.create({
    container: {
        flex: 1,
        alignItems: 'center',
        justifyContent: 'center',
    },
});