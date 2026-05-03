import React from 'react';
import { NavigationContainer } from '@react-navigation/native';
import { createBottomTabNavigator } from '@react-navigation/bottom-tabs';
import { createStackNavigator } from '@react-navigation/stack';
import { StatusBar } from 'expo-status-bar';
import { SafeAreaProvider } from 'react-native-safe-area-context';
import { Ionicons } from '@expo/vector-icons';

import HomeScreen    from './src/screens/HomeScreen';
import ContactScreen from './src/screens/ContactScreen';
import { colors }   from './src/theme/colors';

const Tab   = createBottomTabNavigator();
const Stack = createStackNavigator();

// Home stack (allows navigation from Home → Book Now)
function HomeStack() {
  return (
    <Stack.Navigator screenOptions={{ headerShown: false }}>
      <Stack.Screen name="Home"    component={HomeScreen} />
      <Stack.Screen name="BookNow" component={ContactScreen} />
    </Stack.Navigator>
  );
}

export default function App() {
  return (
    <SafeAreaProvider>
      <StatusBar style="light" />
      <NavigationContainer>
        <Tab.Navigator
          screenOptions={({ route }) => ({
            headerShown: false,
            tabBarActiveTintColor:   colors.red,
            tabBarInactiveTintColor: colors.gray500,
            tabBarStyle: {
              backgroundColor: colors.white,
              borderTopColor: colors.gray100,
              paddingBottom: 8,
              paddingTop: 6,
              height: 62,
            },
            tabBarLabelStyle: { fontSize: 12, fontWeight: '600' },
            tabBarIcon: ({ focused, color, size }) => {
              const icons = {
                HomeTab:    focused ? 'airplane'       : 'airplane-outline',
                ContactTab: focused ? 'paper-plane'    : 'paper-plane-outline',
              };
              return <Ionicons name={icons[route.name]} size={size} color={color} />;
            },
          })}
        >
          <Tab.Screen name="HomeTab"    component={HomeStack}    options={{ title: 'Home' }} />
          <Tab.Screen name="ContactTab" component={ContactScreen} options={{ title: 'Book Now' }} />
        </Tab.Navigator>
      </NavigationContainer>
    </SafeAreaProvider>
  );
}
