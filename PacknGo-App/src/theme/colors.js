// Brand tokens — mirrors the web landing page CSS variables exactly
export const colors = {
  red:        '#CC2033',
  redDark:    '#a81829',
  redLight:   '#f5e8ea',
  navy:       '#1B3A6B',
  navyDark:   '#122850',
  navyLight:  '#2a5299',
  white:      '#ffffff',
  offWhite:   '#f8f9fb',
  gray100:    '#f1f3f7',
  gray300:    '#d1d5de',
  gray500:    '#6b7280',
  gray700:    '#374151',
  gray900:    '#111827',
  heroAccent: '#ffd0d6',
  statAccent: '#ff8a97',
};

export const shadows = {
  card: {
    shadowColor: '#000',
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.10,
    shadowRadius: 16,
    elevation: 4,
  },
  button: {
    shadowColor: colors.red,
    shadowOffset: { width: 0, height: 4 },
    shadowOpacity: 0.35,
    shadowRadius: 10,
    elevation: 6,
  },
};
