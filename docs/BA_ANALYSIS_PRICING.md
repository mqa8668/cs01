# PHÂN TÍCH KỸ THUẬT & BÁO GIÁ GIA CÔNG
## Garden Mind Wellness Application

---

**⚠️ IMPORTANT NOTE**: This document has been superseded by `BA_ANALYSIS_PRICING_FULL.md` which contains the updated 8-week fixed timeline pricing and comprehensive technical analysis with Mermaid diagrams. Please refer to that document for current pricing and project details.

---

**DOCUMENT STATUS**: SUPERSEDED - See `BA_ANALYSIS_PRICING_FULL.md` for current version

---

## I. PHÂN TÍCH TRẠNG THÁI HIỆN TẠI

### 1.1 Dãy code hiện có

**Đã sẵn có** (Production-grade UI components):
- Flutter 3.10.4 với Riverpod state management
- Go Router navigation
- Google Fonts typography
- Theme system (Dark/Light mode)
- Custom painters cho Neural Map (35 nodes)
- Custom painters cho Mind Garden (31 flowers, 8 types)
- 5 screens với animations mượt mà

**Tính năng đã implement**:
- Neural Map: 35 nodes với brain regions, connections, flowing particles
- Mind Garden: 31 flowers với growth stages, atmospheric effects
- Test & Scoring: 5 assessments (GAD-7, PHQ-9, PSS-10, PSQI, MAAS)
- Mini Diary: Mood tracking, entries list, tags
- Care Drops: Placeholder screen

**Chưa có** (Cần implementation):
- Backend/Database (hiện tại mock data)
- Authentication (SSO, email/password)
- Data persistence (local + cloud sync)
- Admin Dashboard
- Real assessment logic & scoring
- QR code generation/scanning
- Multi-language (EN/VN)
- Production-ready API integration

### 1.2 Kiến trúc kỹ thuật đề xuất

```
┌─────────────────────────────────────────────────────────────┐
│                    FRONTEND (Flutter)                        │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │  Neural  │  │  Garden  │  │  Diary   │  │   Test   │   │
│  │   Map    │  │          │  │          │  │          │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
│                                                              │
│  State: Riverpod  |  Router: Go Router  |  Theme: Custom   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    API GATEWAY (Firebase/REST)               │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    BACKEND SERVICES                          │
│  ┌──────────┐  ┌──────────┐  ┌──────────┐  ┌──────────┐   │
│  │   Auth   │  │  Assess  │  │   User   │  │   Care   │   │
│  │ Service  │  │  Service │  │  Service │  │  Service  │   │
│  └──────────┘  └──────────┘  └──────────┘  └──────────┘   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    DATA LAYER                                │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐     │
│  │  Firestore   │  │   DynamoDB   │  │     S3       │     │
│  │  (User data) │  │ (Assessments)│  │  (QR codes)  │     │
│  └──────────────┘  └──────────────┘  └──────────────┘     │
└─────────────────────────────────────────────────────────────┘
```

---

## II. BREAKDOWN TASK CHI TIẾT

### PHASE 1: Nền tảng (Tuần 1-2)

#### Sprint 1.1: Setup & Infrastructure (3-5 ngày)

**Task 1.1.1: Project Setup**
- Tạo Firebase project
- Cấu hình iOS/Android
- Setup CI/CD (GitHub Actions)
- Setup environment variables
- Estimate: 4-6 giờ

**Task 1.1.2: Database Schema Design**
- Thiết kế Firestore collections (users, assessments, diary, garden)
- Thiết kế DynamoDB tables (nếu cần scale)
- Định nghĩa indexes & rules
- Estimate: 6-8 giờ

**Task 1.1.3: Authentication Service**
- Firebase Auth integration
- Google SSO implementation
- Apple SSO implementation (iOS)
- Email/password optional flow
- Session management
- Estimate: 16-20 giờ

**Task 1.1.4: Base API Layer**
- Repository pattern implementation
- Network error handling
- Retry logic & caching
- Estimate: 8-10 giờ

**Tổng Sprint 1.1**: 34-44 giờ (1 dev, ~5 ngày)

---

#### Sprint 1.2: UI Framework Foundation (3-4 ngày)

**Task 1.2.1: Design System Refinement**
- Finalize color palette tokens
- Typography scale adjustments
- Spacing & layout tokens
- Component library (buttons, cards, inputs)
- Estimate: 10-12 giờ

**Task 1.2.2: Theming System**
- Dynamic theme switching
- Persistent theme preference
- Accessibility improvements (WCAG AA)
- Estimate: 6-8 giờ

**Task 1.2.3: Navigation Setup**
- Go Router configuration
- Route guards (auth required)
- Deep linking setup
- Estimate: 4-6 giờ

**Task 1.2.4: Base Widgets**
- Loading states
- Error states
- Empty states
- Toast notifications
- Estimate: 8-10 giờ

**Tổng Sprint 1.2**: 28-36 giờ (1 dev, ~4 ngày)

---

### PHASE 2: Neural Map & Assessments (Tuần 3-4)

#### Sprint 2.1: Neural Map Backend (4-5 ngày)

**Task 2.1.1: Assessment Data Models**
- Assessment question entities
- Answer option entities
- Scoring logic models
- Result calculation services
- Estimate: 10-12 giờ

**Task 2.1.2: Question Bank Management**
- CRUD operations cho questions
- Versioning support
- Multi-language content
- Estimate: 12-16 giờ

**Task 2.1.3: Scoring Engine**
- GAD-7 scoring algorithm
- PHQ-9 scoring algorithm
- PSS-10 scoring algorithm
- PSQI scoring algorithm
- MAAS scoring algorithm
- Trend calculation logic
- Estimate: 16-20 giờ

**Task 2.1.4: Neural State Management**
- Node state persistence
- Activity level calculation
- Connection strength tracking
- Historical data storage
- Estimate: 10-12 giờ

**Tổng Sprint 2.1**: 48-60 giờ (1 dev, ~6 ngày)

---

#### Sprint 2.2: Neural Map Frontend (5-6 ngày)

**Task 2.2.1: Assessment Flow UI**
- Question display screens
- Answer selection components
- Progress indicators
- Transition animations
- Estimate: 12-16 giờ

**Task 2.2.2: Results Screen**
- Score visualization
- Category breakdown
- Trend indicators
- Recommendation display
- Estimate: 10-12 giờ

**Task 2.2.3: Neural Map Integration**
- Update node states post-assessment
- Animation triggers
- Detail view for each node
- Filter by brain region
- Estimate: 14-18 giờ

**Task 2.2.4: History & Tracking**
- Assessment history list
- Date range filtering
- Score trends chart
- Export functionality
- Estimate: 10-12 giờ

**Tổng Sprint 2.2**: 46-58 giờ (1 dev, ~6 ngày)

---

### PHASE 3: Mind Garden (Tuần 5)

#### Sprint 3.1: Garden Backend (3-4 ngày)

**Task 3.1.1: Garden Data Models**
- Flower state entities
- Growth stage logic
- Daily check-in models
- Streak calculation
- Estimate: 8-10 giờ

**Task 3.1.2: Daily Questions Service**
- Question rotation logic
- Answer storage
- Health calculation algorithm
- Flower update triggers
- Estimate: 10-12 giờ

**Task 3.1.3: Garden Persistence**
- Cloud sync logic
- Conflict resolution
- Offline mode support
- Estimate: 8-10 giờ

**Tổng Sprint 3.1**: 26-32 giờ (1 dev, ~3.5 ngày)

---

#### Sprint 3.2: Garden Frontend (3-4 ngày)

**Task 3.2.1: Daily Check-in Flow**
- Question screens (3-5 questions)
- Mood selection
- Submission flow
- Immediate feedback
- Estimate: 10-12 giờ

**Task 3.2.2: Garden Visualization**
- Flower rendering optimization
- Growth animations
- Atmospheric effects refinement
- Performance tuning
- Estimate: 12-16 giờ

**Task 3.2.3: Stats & Gamification**
- Health percentage display
- Streak counter
- Achievement badges
- Motivational messages
- Estimate: 8-10 giờ

**Tổng Sprint 3.2**: 30-38 giờ (1 dev, ~4 ngày)

---

### PHASE 4: Mini Diary (Tuần 6)

#### Sprint 4.1: Diary Backend (2-3 ngày)

**Task 4.1.1: Diary Data Models**
- Entry entities
- Mood tags
- Search indexes
- Estimate: 6-8 giờ

**Task 4.1.2: Diary Services**
- CRUD operations
- Search functionality
- Tag management
- Estimate: 8-10 giờ

**Tổng Sprint 4.1**: 14-18 giờ (1 dev, ~2 ngày)

---

#### Sprint 4.2: Diary Frontend (3-4 ngày)

**Task 4.2.1: Entry Creation**
- Rich text editor
- Mood picker
- Tag input
- Word count
- Estimate: 10-12 giờ

**Task 4.2.2: Entry List & Search**
- List with filters
- Search by tag/content
- Date range filter
- Mood filter
- Estimate: 8-10 giờ

**Task 4.2.3: Garden Integration**
- Tap flower to view entry
- Link diary mood to flower state
- Estimate: 4-6 giờ

**Tổng Sprint 4.2**: 22-28 giờ (1 dev, ~3 ngày)

---

### PHASE 5: Care Drops (Tuần 6-7)

#### Sprint 5.1: Peer Matching Backend (4-5 ngày)

**Task 5.1.1: QR Code System**
- QR generation API
- QR validation logic
- Unique ID management
- Estimate: 8-10 giờ

**Task 5.1.2: Matching Service**
- Anonymous pairing algorithm
- Availability tracking
- Match persistence
- Estimate: 10-12 giờ

**Task 5.1.3: Messaging Service**
- Real-time messaging
- Message status (sent/read)
- Conversation history
- Estimate: 12-16 giờ

**Task 5.1.4: Moderation Tools**
- Block user functionality
- Report system
- Auto-flag keywords
- Estimate: 8-10 giờ

**Tổng Sprint 5.1**: 38-48 giờ (1 dev, ~5 ngày)

---

#### Sprint 5.2: Care Drops Frontend (4-5 ngày)

**Task 5.2.1: QR Scanner**
- Camera integration
- QR parsing
- Validation feedback
- Estimate: 10-12 giờ

**Task 5.2.2: Chat UI**
- Message thread display
- Send/receive flow
- Typing indicators
- Online status
- Estimate: 14-18 giờ

**Task 5.2.3: Privacy Controls**
- Block/report UI
- Privacy settings
- Anonymous mode toggle
- Estimate: 6-8 giờ

**Tổng Sprint 5.2**: 30-38 giờ (1 dev, ~4.5 ngày)

---

### PHASE 6: Admin & Localization (Tuần 7)

#### Sprint 6.1: Admin Dashboard (5-6 ngày)

**Task 6.1.1: Admin Auth**
- Admin role management
- Login/logout
- Permission checks
- Estimate: 6-8 giờ

**Task 6.1.2: Assessment Management**
- CRUD questions
- CRUD assessments
- Content preview
- Estimate: 12-16 giờ

**Task 6.1.3: User Management**
- User list with filters
- View user data
- Export user data
- Estimate: 8-10 giờ

**Task 6.1.4: Analytics Dashboard**
- User metrics
- Assessment completion rates
- Garden health stats
- Estimate: 10-12 giờ

**Tổng Sprint 6.1**: 36-46 giờ (1 dev, ~5.5 ngày)

---

#### Sprint 6.2: Multi-language (3-4 ngày)

**Task 6.2.1: i18n Setup**
- Localization framework
- EN/VN translations
- Language switcher
- Estimate: 10-12 giờ

**Task 6.2.2: Content Translation**
- Assessment questions
- UI strings
- Error messages
- Estimate: 12-16 giờ

**Tổng Sprint 6.2**: 22-28 giờ (1 dev, ~3 ngày)

---

### PHASE 7: QA & Launch (Tuần 8)

#### Sprint 7.1: Testing (4-5 ngày)

**Task 7.1.1: Unit Testing**
- Business logic tests
- Service layer tests
- Utility tests
- Estimate: 16-20 giờ

**Task 7.1.2: Integration Testing**
- API integration tests
- Auth flow tests
- Data sync tests
- Estimate: 12-16 giờ

**Task 7.1.3: UI Testing**
- Widget tests
- Navigation tests
- Screenshot tests
- Estimate: 10-12 giờ

**Tổng Sprint 7.1**: 38-48 giờ (1 dev, ~5 ngày)

---

#### Sprint 7.2: Deployment & Handover (3-4 ngày)

**Task 7.2.1: App Store Preparation**
- iOS app metadata
- Screenshots
- Privacy policy
- Estimate: 6-8 giờ

**Task 7.2.2: Play Store Preparation**
- Android app metadata
- Screenshots
- Content rating
- Estimate: 4-6 giờ

**Task 7.2.3: Deployment**
- TestFlight setup
- Play Internal Testing
- Production builds
- Estimate: 6-8 giờ

**Task 7.2.4: Documentation**
- Technical documentation
- API documentation
- Admin guide
- Handover session
- Estimate: 8-10 giờ

**Tổng Sprint 7.2**: 24-32 giờ (1 dev, ~3.5 ngày)

---

## III. BÁO GIÁ CHI TIẾT

### 3.1 Bảng giá theo vai trò

| Vai trò | Mức lương/giờ | Giải thích |
|---------|--------------|------------|
| Senior Flutter Dev | $35-50 | 5+ năm KN, expert Flutter/Dart |
| Mid Flutter Dev | $25-35 | 2-5 năm KN, solid Flutter skills |
| Backend Dev | $30-45 | Node.js/Firebase expert |
| UI/UX Designer | $30-40 | Refinement & polish |
| QA Engineer | $20-30 | Testing & bug fixing |
| DevOps | $35-50 | CI/CD, deployment |

### 3.2 Bảng báo giá theo Sprint

#### Option 1: MVP STANDARD

| Phase | Sprint | Tasks | Hours | Rate | Total (USD) |
|-------|--------|-------|-------|------|-------------|
| 1 | 1.1 | Setup & Infrastructure | 34-44 | $40 | $1,360-1,760 |
| 1 | 1.2 | UI Framework | 28-36 | $40 | $1,120-1,440 |
| 2 | 2.1 | Neural Map Backend | 48-60 | $45 | $2,160-2,700 |
| 2 | 2.2 | Neural Map Frontend | 46-58 | $40 | $1,840-2,320 |
| 3 | 3.1 | Garden Backend | 26-32 | $40 | $1,040-1,280 |
| 3 | 3.2 | Garden Frontend | 30-38 | $40 | $1,200-1,520 |
| 4 | 4.1 | Diary Backend | 14-18 | $35 | $490-630 |
| 4 | 4.2 | Diary Frontend | 22-28 | $35 | $770-980 |
| 5 | 5.1 | Peer Matching Backend | 38-48 | $45 | $1,710-2,160 |
| 5 | 5.2 | Care Drops Frontend | 30-38 | $35 | $1,050-1,330 |
| 6 | 6.1 | Admin Dashboard | 36-46 | $35 | $1,260-1,610 |
| 6 | 6.2 | Multi-language | 22-28 | $30 | $660-840 |
| 7 | 7.1 | Testing | 38-48 | $25 | $950-1,200 |
| 7 | 7.2 | Deployment | 24-32 | $40 | $960-1,280 |
| | | | | | |
| | **TỔNG KHOẢN** | | **436-556 giờ** | | **$15,570-20,050** |

**Giảm giá cho gói**: 15-20%
**FINAL MVP STANDARD**: **$12,500 - $16,000**

---

#### Option 2: MVP PREMIUM

Bao gồm tất cả MVP Standard +:

| Thêm | Tasks | Hours | Rate | Total (USD) |
|------|-------|-------|------|-------------|
| UI Polish | Enhanced animations | 40-50 | $40 | $1,600-2,000 |
| UI Polish | Micro-interactions | 30-40 | $40 | $1,200-1,600 |
| Performance | Optimization | 20-30 | $45 | $900-1,350 |
| Analytics | Advanced admin analytics | 24-32 | $40 | $960-1,280 |
| Support | Priority support 3 tháng | - | - | $1,500 |
| | | | | |
| | **THÊM VÀO** | | **114-152 giờ** | | **$6,160-7,230** |

**Base**: $12,500 - $16,000
**Add-on**: $6,160 - $7,230
**FINAL MVP PREMIUM**: **$18,660 - $23,230** (~$19,000 - $23,000)

---

#### Option 3: CUSTOM SCOPE

Chọn phạm vi tùy chỉnh:

| Component | Đ bán lẻ | Giá |
|-----------|----------|-----|
| Neural Map + Tests | Có | $5,000-6,500 |
| Mind Garden | Có | $2,500-3,500 |
| Mini Diary | Có | $1,500-2,000 |
| Care Drops | Có | $3,000-4,000 |
| Admin Dashboard | Có | $2,000-2,500 |
| Multi-language | Có | $800-1,200 |

**Giảm khi gộp package**: 10-15%

---

### 3.3 Lịch trình thanh toán đề xuất

#### Cho MVP Standard ($12,500 - $16,000)

| Milestone | % | Số tiền | Khi nào |
|-----------|---|---------|---------|
| Deposit | 30% | $3,750-4,800 | Kickoff (Tuần 1) |
| Mid-project | 40% | $5,000-6,400 | Cuối Tuần 4 (xong Neural Map + Garden) |
| Delivery | 30% | $3,750-4,800 | Cuối Tuần 8 (QA + Deployment xong) |

#### Cho MVP Premium ($19,000 - $23,000)

| Milestone | % | Số tiền | Khi nào |
|-----------|---|---------|---------|
| Deposit | 30% | $5,700-6,900 | Kickoff (Tuần 1) |
| Mid-project | 40% | $7,600-9,200 | Cuối Tuần 5 (xong core features) |
| Final polish | 20% | $3,800-4,600 | Cuối Tuần 8 (feature complete) |
| Warranty | 10% | $1,900-2,300 | Sau 2 tuần ổn định |

---

## IV. RỦI RO & PHƯƠNG PHÁP

### 4.1 Rủi ro kỹ thuật

| Rủi ro | Khả năng | Tác động | Phương án |
|--------|----------|----------|-----------|
| Animation performance | Trung bình | Cao | Custom painters, lazy loading |
| Cross-platform bugs | Thấp | Trung bình | Device testing matrix |
| Data sync conflicts | Trung bình | Trung bình | Conflict resolution logic |
| API rate limits | Thấp | Thấp | Caching strategy |

### 4.2 Rủi ro timeline

| Rủi ro | Phương án |
|--------|-----------|
| Scope creep | Change order process, fixed scope |
| Resource availability | Backup developers allocated |
| Third-party delays | Minimize dependencies |

### 4.3 Rủi ro ngân sách

| Rủi ro | Phương án |
|--------|-----------|
| Requirement changes | Clear change order pricing |
| Integration complexity | Technical discovery upfront |
| Testing overhead | Included in base estimate |

---

## V. KẾT LUẬN

### Tóm tắt

- **Total hours**: 436-556 giờ (Standard) hoặc 550-708 giờ (Premium)
- **Team size**: 2-3 developers (1 Senior Flutter + 1 Mid Flutter + 1 Backend part-time)
- **Timeline**: 8-10 tuần
- **Pricing**: $12,500-16,000 (Standard) hoặc $19,000-23,000 (Premium)

### Lợi ích chọn dịch vụ gia công

1. **Expert team**: Đội ngũ đã có kinh nghiệm Flutter + Wellness apps
2. **Faster delivery**: Parallel development với team
3. **Flexibility**: Dễ scale lên xuống theo yêu cầu
4. **Risk mitigation**: Contract với SLA, warranty
5. **Focus**: Bạn tập trung vào business, team lo kỹ thuật

### Bước tiếp theo

Bạn cần chọn giúp em:

1. Chọn option nào? (Standard / Premium / Custom)
2. Timeline có OK không? (8-10 tuần)
3. Có cần điều chỉnh scope không? (thêm/bớt tính năng)
4. Khi nào có thể kickoff?

---

*(BA Agent - Chuyên gia Tư vấn Trưởng, 30+ năm kinh nghiệm)*
