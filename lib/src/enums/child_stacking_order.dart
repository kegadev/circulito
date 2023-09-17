/// The order in which a child is stacked relative to the parent.
///
/// Could be `behindParent` or `inFrontOfParent`.
enum ChildStackingOrder {
  /// The child is stacked below the other children.
  behindParent,

  /// The child is stacked above the other children.
  inFrontOfParent,
}
