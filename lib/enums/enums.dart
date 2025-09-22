enum FilterViewType {
  normalDisplay,
  brandFilterView,
  sortByFilterView,
  localFilterView,
  internationalFilterView,
  otherBrandFilterView,
  categoryFilterView,
  typeFilterView,
  sizeFilterView,
  conditionFilterView,
}

enum HomeViewType {
  searchSuggestions,
  normalDisplay,
}

enum BrandType {
  local,
  international,
}

enum SellerViewType {
  storeView,
  sellerReviewsView,
}

enum SellerReviewView {
  photos,
  videos,
}

enum FollowersFollowingViewType {
  followersView,
  followingView,
}

enum InboxViewType {
  notificationsView,
  chatsView,
}

enum OfferStatus {
  accepted,
  rejected,
  pending,
}

enum ListingsViewType {
  soldView,
  activeListingsView,
}

enum OrderStatus {
  ordered,
  shipped,
  delivered,
}

enum NotificationType {
  followStarted,
  orderPlaced,
  orderRejected,
  orderStatusShipped,
  orderStatusDelivered,
  issueOpened,
  issueUpdated,
  offerReceived,
  offerAccepted,
  offerRejected,
  reviewReceived,
  topSeller,
}

enum ReviewSubmissionView {
  submissionView,
  submittedView,
}
