import React, { useState } from 'react';
import {
  View, Text, TextInput, TouchableOpacity, ScrollView,
  StyleSheet, KeyboardAvoidingView, Platform, Alert,
} from 'react-native';
import { LinearGradient } from 'expo-linear-gradient';
import { Ionicons } from '@expo/vector-icons';
import { colors, shadows } from '../theme/colors';

// ── Data ──────────────────────────────────────────────────────────────────────

const INTERESTS = [
  { key: 'leisure',   label: 'Leisure',   icon: 'sunny' },
  { key: 'adventure', label: 'Adventure', icon: 'trail-sign' },
  { key: 'cultural',  label: 'Cultural',  icon: 'business' },
  { key: 'business',  label: 'Business',  icon: 'briefcase' },
  { key: 'honeymoon', label: 'Honeymoon', icon: 'heart' },
  { key: 'family',    label: 'Family',    icon: 'people' },
];

// ── Component ─────────────────────────────────────────────────────────────────

export default function ContactScreen() {
  const [form, setForm] = useState({
    fullName: '', email: '', phone: '',
    destination: '', travelers: 2,
    interest: 'leisure', message: '',
  });
  const [submitted, setSubmitted] = useState(false);
  const [loading, setLoading]     = useState(false);
  const [error, setError]         = useState('');

  const update = (field, value) => setForm(prev => ({ ...prev, [field]: value }));

  const handleSubmit = () => {
    if (!form.fullName.trim() || !form.email.includes('@') || !form.destination.trim()) {
      setError('Please fill in your name, email, and destination.');
      return;
    }
    setError('');
    setLoading(true);
    setTimeout(() => { setLoading(false); setSubmitted(true); }, 1800);
  };

  if (submitted) return <SuccessScreen name={form.fullName} onReset={() => { setSubmitted(false); setForm({ fullName: '', email: '', phone: '', destination: '', travelers: 2, interest: 'leisure', message: '' }); }} />;

  return (
    <KeyboardAvoidingView
      style={{ flex: 1 }}
      behavior={Platform.OS === 'ios' ? 'padding' : undefined}
    >
      <ScrollView style={styles.root} showsVerticalScrollIndicator={false}>

        {/* Header */}
        <LinearGradient
          colors={[colors.navyDark, colors.navy]}
          start={{ x: 0, y: 0 }} end={{ x: 1, y: 1 }}
          style={styles.header}
        >
          <Text style={styles.headerEyebrow}>BOOK YOUR TRIP</Text>
          <Text style={styles.headerTitle}>Plan Your{'\n'}Perfect Journey</Text>
          <Text style={styles.headerSub}>
            Fill in the details and our team will craft your tailored itinerary within 24 hours.
          </Text>
        </LinearGradient>

        <View style={styles.body}>

          {/* ── Contact Info ── */}
          <FormSection title="Contact Information" icon="person">
            <BrandInput label="Full Name *" placeholder="e.g. Sarah Connor" value={form.fullName} onChangeText={v => update('fullName', v)} />
            <BrandInput label="Email Address *" placeholder="you@example.com" value={form.email} onChangeText={v => update('email', v)} keyboardType="email-address" autoCapitalize="none" />
            <BrandInput label="Phone Number" placeholder="+1 (555) 000-0000" value={form.phone} onChangeText={v => update('phone', v)} keyboardType="phone-pad" />
          </FormSection>

          {/* ── Trip Details ── */}
          <FormSection title="Trip Details" icon="globe">
            <BrandInput label="Dream Destination *" placeholder="e.g. Bali, Paris, Maldives…" value={form.destination} onChangeText={v => update('destination', v)} />

            {/* Travelers stepper */}
            <View style={styles.fieldWrap}>
              <Text style={styles.fieldLabel}>Number of Travelers</Text>
              <View style={styles.stepper}>
                <TouchableOpacity
                  style={styles.stepBtn}
                  onPress={() => update('travelers', Math.max(1, form.travelers - 1))}
                >
                  <Ionicons name="remove" size={18} color={colors.navy} />
                </TouchableOpacity>
                <Text style={styles.stepValue}>{form.travelers} {form.travelers === 1 ? 'Traveler' : 'Travelers'}</Text>
                <TouchableOpacity
                  style={styles.stepBtn}
                  onPress={() => update('travelers', Math.min(30, form.travelers + 1))}
                >
                  <Ionicons name="add" size={18} color={colors.navy} />
                </TouchableOpacity>
              </View>
            </View>
          </FormSection>

          {/* ── Travel Interest ── */}
          <FormSection title="Travel Interest" icon="star">
            <View style={styles.interestGrid}>
              {INTERESTS.map(item => {
                const selected = form.interest === item.key;
                return (
                  <TouchableOpacity
                    key={item.key}
                    style={[styles.interestChip, selected && styles.interestChipSelected]}
                    onPress={() => update('interest', item.key)}
                    activeOpacity={0.8}
                  >
                    <Ionicons
                      name={item.icon}
                      size={20}
                      color={selected ? colors.white : colors.navy}
                    />
                    <Text style={[styles.interestLabel, selected && styles.interestLabelSelected]}>
                      {item.label}
                    </Text>
                  </TouchableOpacity>
                );
              })}
            </View>
          </FormSection>

          {/* ── Message ── */}
          <FormSection title="Additional Notes" icon="chatbubble">
            <View style={styles.fieldWrap}>
              <Text style={styles.fieldLabel}>Anything else we should know?</Text>
              <TextInput
                style={[styles.input, styles.textArea]}
                placeholder="Special requests, dietary needs, preferred airlines…"
                placeholderTextColor={colors.gray300}
                value={form.message}
                onChangeText={v => update('message', v)}
                multiline
                numberOfLines={4}
                textAlignVertical="top"
              />
            </View>
          </FormSection>

          {/* Error */}
          {!!error && (
            <View style={styles.errorBox}>
              <Ionicons name="warning" size={16} color={colors.red} />
              <Text style={styles.errorText}>{error}</Text>
            </View>
          )}

          {/* Submit */}
          <TouchableOpacity
            style={[styles.submitBtn, shadows.button, loading && styles.submitBtnDisabled]}
            onPress={handleSubmit}
            disabled={loading}
            activeOpacity={0.85}
          >
            {loading
              ? <Text style={styles.submitBtnText}>Sending…</Text>
              : <>
                  <Text style={styles.submitBtnText}>Send My Enquiry</Text>
                  <Ionicons name="arrow-forward" size={16} color={colors.white} />
                </>
            }
          </TouchableOpacity>

          {/* Footer contacts */}
          <View style={styles.footer}>
            <Text style={styles.footerLabel}>Or reach us directly</Text>
            <View style={styles.footerLinks}>
              <Ionicons name="call" size={14} color={colors.navy} />
              <Text style={styles.footerText}>+1 (000) 000-0000</Text>
              <Ionicons name="mail" size={14} color={colors.navy} style={{ marginLeft: 16 }} />
              <Text style={styles.footerText}>hello@packngo.com</Text>
            </View>
          </View>

        </View>
      </ScrollView>
    </KeyboardAvoidingView>
  );
}

// ── Success Screen ────────────────────────────────────────────────────────────

function SuccessScreen({ name, onReset }) {
  const firstName = name.split(' ')[0] || 'Traveler';
  return (
    <View style={styles.successWrap}>
      <View style={styles.successIcon}>
        <Ionicons name="checkmark-circle" size={72} color={colors.red} />
      </View>
      <Text style={styles.successTitle}>Request Sent!</Text>
      <Text style={styles.successSub}>
        Thank you, {firstName}! Our team will reach you within 24 hours with your personalized itinerary.
      </Text>
      <TouchableOpacity style={[styles.submitBtn, shadows.button, { width: 220 }]} onPress={onReset}>
        <Ionicons name="refresh" size={16} color={colors.white} />
        <Text style={styles.submitBtnText}>Plan Another Trip</Text>
      </TouchableOpacity>
    </View>
  );
}

// ── Reusable components ───────────────────────────────────────────────────────

function FormSection({ title, icon, children }) {
  return (
    <View style={[styles.card, shadows.card]}>
      <View style={styles.cardHeader}>
        <Ionicons name={icon} size={14} color={colors.red} />
        <Text style={styles.cardTitle}>{title}</Text>
      </View>
      {children}
    </View>
  );
}

function BrandInput({ label, ...props }) {
  return (
    <View style={styles.fieldWrap}>
      <Text style={styles.fieldLabel}>{label}</Text>
      <TextInput style={styles.input} placeholderTextColor={colors.gray300} {...props} />
    </View>
  );
}

// ── Styles ────────────────────────────────────────────────────────────────────

const styles = StyleSheet.create({
  root: { flex: 1, backgroundColor: colors.offWhite },

  // Header
  header: { paddingTop: 64, paddingBottom: 32, paddingHorizontal: 24, alignItems: 'center' },
  headerEyebrow: { color: 'rgba(255,255,255,0.65)', fontSize: 11, fontWeight: '700', letterSpacing: 1.4, marginBottom: 10 },
  headerTitle:   { fontSize: 28, fontWeight: '800', color: colors.white, textAlign: 'center', lineHeight: 36, marginBottom: 10 },
  headerSub:     { fontSize: 13, color: 'rgba(255,255,255,0.70)', textAlign: 'center', lineHeight: 20 },

  body: { padding: 20, gap: 16 },

  // Cards
  card: { backgroundColor: colors.white, borderRadius: 16, padding: 16, marginBottom: 4 },
  cardHeader: { flexDirection: 'row', alignItems: 'center', gap: 8, marginBottom: 14 },
  cardTitle:  { fontSize: 14, fontWeight: '700', color: colors.navy },

  // Fields
  fieldWrap:  { marginBottom: 12 },
  fieldLabel: { fontSize: 12, fontWeight: '600', color: colors.gray700, marginBottom: 6 },
  input: {
    backgroundColor: colors.offWhite, borderRadius: 10,
    borderWidth: 1, borderColor: colors.gray300,
    paddingHorizontal: 14, paddingVertical: 12,
    fontSize: 15, color: colors.gray900,
  },
  textArea: { minHeight: 100, paddingTop: 12 },

  // Stepper
  stepper: {
    flexDirection: 'row', alignItems: 'center',
    backgroundColor: colors.offWhite,
    borderRadius: 10, borderWidth: 1, borderColor: colors.gray300,
    overflow: 'hidden',
  },
  stepBtn: {
    width: 44, height: 48, alignItems: 'center', justifyContent: 'center',
    backgroundColor: colors.gray100,
  },
  stepValue: { flex: 1, textAlign: 'center', fontSize: 15, fontWeight: '600', color: colors.navy },

  // Interest grid
  interestGrid: { flexDirection: 'row', flexWrap: 'wrap', gap: 10 },
  interestChip: {
    width: '30%', alignItems: 'center', paddingVertical: 12,
    backgroundColor: colors.offWhite, borderRadius: 12,
    borderWidth: 1, borderColor: colors.gray300, gap: 6,
  },
  interestChipSelected: { backgroundColor: colors.red, borderColor: colors.red },
  interestLabel:         { fontSize: 11, fontWeight: '600', color: colors.gray700 },
  interestLabelSelected: { color: colors.white },

  // Error
  errorBox: {
    flexDirection: 'row', alignItems: 'center', gap: 8,
    backgroundColor: colors.redLight, borderRadius: 10, padding: 14,
  },
  errorText: { fontSize: 13, color: colors.red, flex: 1 },

  // Submit
  submitBtn: {
    backgroundColor: colors.red, borderRadius: 12,
    paddingVertical: 16, flexDirection: 'row',
    alignItems: 'center', justifyContent: 'center', gap: 8,
  },
  submitBtnDisabled: { opacity: 0.65 },
  submitBtnText: { color: colors.white, fontWeight: '700', fontSize: 16 },

  // Footer
  footer: { alignItems: 'center', paddingTop: 8, paddingBottom: 32 },
  footerLabel: { fontSize: 12, color: colors.gray500, marginBottom: 8 },
  footerLinks: { flexDirection: 'row', alignItems: 'center', gap: 6 },
  footerText:  { fontSize: 13, color: colors.navy, fontWeight: '500' },

  // Success
  successWrap: { flex: 1, alignItems: 'center', justifyContent: 'center', padding: 32, backgroundColor: colors.offWhite },
  successIcon: { marginBottom: 24 },
  successTitle: { fontSize: 30, fontWeight: '800', color: colors.navy, marginBottom: 14 },
  successSub:   { fontSize: 15, color: colors.gray500, textAlign: 'center', lineHeight: 23, marginBottom: 32 },
});
