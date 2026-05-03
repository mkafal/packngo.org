import React from 'react';
import {
  View, Text, ScrollView, TouchableOpacity,
  StyleSheet, ImageBackground, Dimensions,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { colors, shadows } from '../theme/colors';

const { width } = Dimensions.get('window');

// ── Data ──────────────────────────────────────────────────────────────────────

const STATS = [
  { num: '50K+', label: 'Travelers' },
  { num: '120+', label: 'Destinations' },
  { num: '15yr', label: 'Experience' },
  { num: '4.9★', label: 'Rating' },
];

const FEATURES = [
  { icon: 'shield-checkmark',  title: 'Safe & Trusted',        body: 'IATA-certified, 15 years of flawless operations across 120+ countries.' },
  { icon: 'pricetag',          title: 'Best Price',            body: 'We match or beat any comparable offer — no compromise on value.' },
  { icon: 'headset',           title: '24/7 Support',          body: 'Multilingual team on standby wherever in the world you may be.' },
  { icon: 'map',               title: 'Tailored Trips',        body: 'Every journey built around your interests, pace, and budget.' },
];

// ── Component ─────────────────────────────────────────────────────────────────

export default function HomeScreen({ navigation }) {
  return (
    <ScrollView style={styles.root} showsVerticalScrollIndicator={false}>

      {/* ── Hero ── */}
      <ImageBackground
        source={{ uri: 'https://images.unsplash.com/photo-1476514525535-07fb3b4ae5f1?w=800&q=80' }}
        style={styles.heroBg}
        resizeMode="cover"
      >
        <LinearGradient
          colors={['rgba(27,58,107,0.88)', 'rgba(204,32,51,0.80)']}
          start={{ x: 0, y: 0 }}
          end={{ x: 1, y: 1 }}
          style={styles.heroGradient}
        >
          {/* Eyebrow pill */}
          <View style={styles.eyebrow}>
            <View style={styles.eyebrowDot} />
            <Text style={styles.eyebrowText}>PREMIUM TRAVEL AGENCY</Text>
          </View>

          {/* Headline */}
          <Text style={styles.heroTitle}>Fly Your</Text>
          <Text style={[styles.heroTitle, styles.heroTitleItalic]}>Dreams</Text>

          {/* Subheadline */}
          <Text style={styles.heroSub}>
            Crafting unforgettable journeys across 120+ destinations — tailor-made for every traveler.
          </Text>

          {/* CTA buttons */}
          <View style={styles.heroCtas}>
            <TouchableOpacity
              style={[styles.btnPrimary, shadows.button]}
              onPress={() => navigation.navigate('BookNow')}
              activeOpacity={0.85}
            >
              <Ionicons name="paper-plane" size={16} color={colors.white} />
              <Text style={styles.btnPrimaryText}>Book Now</Text>
            </TouchableOpacity>

            <TouchableOpacity style={styles.btnOutline} activeOpacity={0.75}>
              <Ionicons name="globe-outline" size={16} color={colors.white} />
              <Text style={styles.btnOutlineText}>Explore</Text>
            </TouchableOpacity>
          </View>
        </LinearGradient>
      </ImageBackground>

      {/* ── Stats bar ── */}
      <View style={[styles.statsBar, shadows.card]}>
        {STATS.map((s, i) => (
          <React.Fragment key={s.label}>
            <View style={styles.statItem}>
              <Text style={styles.statNum}>{s.num}</Text>
              <Text style={styles.statLabel}>{s.label}</Text>
            </View>
            {i < STATS.length - 1 && <View style={styles.statDivider} />}
          </React.Fragment>
        ))}
      </View>

      {/* ── Why PacknGo ── */}
      <View style={styles.section}>
        <View style={styles.sectionPill}>
          <Text style={styles.sectionPillText}>WHY PACKNGO</Text>
        </View>
        <Text style={styles.sectionTitle}>Travel Smarter,{'\n'}Experience More</Text>
        <Text style={styles.sectionSub}>
          We handle every detail so you can focus on making memories.
        </Text>

        <View style={styles.featureGrid}>
          {FEATURES.map((f) => (
            <View key={f.title} style={[styles.featureCard, shadows.card]}>
              <View style={styles.featureIconWrap}>
                <Ionicons name={f.icon} size={22} color={colors.red} />
              </View>
              <Text style={styles.featureTitle}>{f.title}</Text>
              <Text style={styles.featureBody}>{f.body}</Text>
            </View>
          ))}
        </View>
      </View>

      {/* ── CTA banner ── */}
      <LinearGradient
        colors={[colors.navyDark, colors.navy]}
        start={{ x: 0, y: 0 }}
        end={{ x: 1, y: 1 }}
        style={styles.ctaBanner}
      >
        <Text style={styles.ctaTitle}>Ready to Fly{'\n'}Your Dream?</Text>
        <Text style={styles.ctaSub}>
          Get a personalized quote from our travel experts — no commitment required.
        </Text>
        <TouchableOpacity
          style={styles.ctaBtn}
          onPress={() => navigation.navigate('BookNow')}
          activeOpacity={0.85}
        >
          <Text style={styles.ctaBtnText}>Get a Free Quote</Text>
          <Ionicons name="arrow-forward-circle" size={18} color={colors.navy} />
        </TouchableOpacity>
      </LinearGradient>

    </ScrollView>
  );
}

// ── Styles ────────────────────────────────────────────────────────────────────

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.offWhite },

  // Hero
  heroBg:       { width: '100%', height: 520 },
  heroGradient: { flex: 1, alignItems: 'center', justifyContent: 'center', paddingHorizontal: 24, paddingTop: 60 },
  eyebrow: {
    flexDirection: 'row', alignItems: 'center', gap: 8,
    backgroundColor: 'rgba(255,255,255,0.15)',
    borderWidth: 1, borderColor: 'rgba(255,255,255,0.25)',
    paddingHorizontal: 18, paddingVertical: 7,
    borderRadius: 999, marginBottom: 24,
  },
  eyebrowDot:   { width: 7, height: 7, borderRadius: 999, backgroundColor: colors.statAccent },
  eyebrowText:  { color: colors.white, fontSize: 11, fontWeight: '700', letterSpacing: 1.4 },
  heroTitle:    { fontSize: 52, fontWeight: '800', color: colors.white, lineHeight: 58, textAlign: 'center' },
  heroTitleItalic: { color: colors.heroAccent, fontStyle: 'italic' },
  heroSub: {
    fontSize: 15, color: 'rgba(255,255,255,0.82)',
    textAlign: 'center', marginTop: 14, marginBottom: 32,
    lineHeight: 22,
  },
  heroCtas:     { flexDirection: 'row', gap: 12 },
  btnPrimary: {
    flexDirection: 'row', alignItems: 'center', gap: 8,
    backgroundColor: colors.red,
    paddingHorizontal: 22, paddingVertical: 14,
    borderRadius: 10,
  },
  btnPrimaryText: { color: colors.white, fontWeight: '600', fontSize: 15 },
  btnOutline: {
    flexDirection: 'row', alignItems: 'center', gap: 8,
    borderWidth: 1.5, borderColor: 'rgba(255,255,255,0.6)',
    paddingHorizontal: 22, paddingVertical: 13,
    borderRadius: 10,
  },
  btnOutlineText: { color: colors.white, fontWeight: '600', fontSize: 15 },

  // Stats bar
  statsBar: {
    flexDirection: 'row', alignItems: 'center',
    backgroundColor: colors.white,
    borderRadius: 16, marginHorizontal: 20,
    marginTop: -28, paddingVertical: 18,
    paddingHorizontal: 8,
  },
  statItem:    { flex: 1, alignItems: 'center' },
  statNum:     { fontSize: 20, fontWeight: '800', color: colors.navy },
  statLabel:   { fontSize: 11, color: colors.gray500, marginTop: 2 },
  statDivider: { width: 1, height: 36, backgroundColor: colors.gray300 },

  // Why section
  section: { paddingHorizontal: 20, paddingTop: 36, paddingBottom: 8 },
  sectionPill: {
    alignSelf: 'flex-start',
    backgroundColor: colors.redLight,
    borderRadius: 999, paddingHorizontal: 14, paddingVertical: 5,
    marginBottom: 12,
  },
  sectionPillText: { color: colors.red, fontSize: 11, fontWeight: '700', letterSpacing: 1.4 },
  sectionTitle:    { fontSize: 28, fontWeight: '800', color: colors.navy, lineHeight: 36, marginBottom: 10 },
  sectionSub:      { fontSize: 14, color: colors.gray500, lineHeight: 21, marginBottom: 24 },

  featureGrid: {
    flexDirection: 'row', flexWrap: 'wrap', gap: 14,
  },
  featureCard: {
    width: (width - 40 - 14) / 2,
    backgroundColor: colors.white,
    borderRadius: 16, padding: 16,
  },
  featureIconWrap: {
    width: 44, height: 44, borderRadius: 12,
    backgroundColor: colors.redLight,
    alignItems: 'center', justifyContent: 'center',
    marginBottom: 12,
  },
  featureTitle: { fontSize: 13, fontWeight: '700', color: colors.navy, marginBottom: 6 },
  featureBody:  { fontSize: 12, color: colors.gray500, lineHeight: 18 },

  // CTA banner
  ctaBanner: {
    margin: 20, borderRadius: 20,
    padding: 32, alignItems: 'center',
  },
  ctaTitle: {
    fontSize: 28, fontWeight: '800', color: colors.white,
    textAlign: 'center', lineHeight: 36, marginBottom: 12,
  },
  ctaSub: {
    fontSize: 14, color: 'rgba(255,255,255,0.72)',
    textAlign: 'center', lineHeight: 21, marginBottom: 24,
  },
  ctaBtn: {
    flexDirection: 'row', alignItems: 'center', gap: 8,
    backgroundColor: colors.white,
    paddingHorizontal: 24, paddingVertical: 14,
    borderRadius: 10,
  },
  ctaBtnText: { color: colors.navy, fontWeight: '700', fontSize: 15 },
});
