# Required Fields with Red Asterisks

The `FitThereTextField` widget now supports required field indicators with red asterisks (*). This feature helps users identify which fields are mandatory in forms.

## How to Use

### 1. With Labels (Recommended)

When you provide a `labelText`, the red asterisk will appear next to the label:

```dart
FitThereTextField(
  controller: _nameController,
  labelText: 'Full name',
  hintText: 'Enter your full name',
  isRequired: true, // This adds the red asterisk
  validator: FieldValidators.nameValidator,
  type: FitThereTextFieldType.text,
),
```

**Result:** The label will display as "Full name *" with the asterisk in red.

### 2. Without Labels (Hint Text Only)

When you don't provide a `labelText` but want to show the required indicator, the asterisk will be added to the hint text:

```dart
FitThereTextField(
  controller: _emailController,
  hintText: 'Email address',
  isRequired: true, // This adds the red asterisk to hint text
  validator: FieldValidators.emailValidator,
  type: FitThereTextFieldType.email,
),
```

**Result:** The hint text will display as "Email address*" with the asterisk in red.

### 3. Optional Fields

For optional fields, simply don't set `isRequired` or set it to `false`:

```dart
FitThereTextField(
  controller: _phoneController,
  labelText: 'Phone number (optional)',
  hintText: 'Enter your phone number',
  isRequired: false, // No asterisk will be shown
  type: FitThereTextFieldType.number,
),
```

## Complete Example

```dart
class ContactForm extends StatefulWidget {
  @override
  _ContactFormState createState() => _ContactFormState();
}

class _ContactFormState extends State<ContactForm> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          // Required field with label
          FitThereTextField(
            controller: _nameController,
            labelText: 'Full name',
            hintText: 'Enter your full name',
            isRequired: true,
            validator: FieldValidators.nameValidator,
            type: FitThereTextFieldType.text,
          ),
          
          const SizedBox(height: 16),
          
          // Required field without label (asterisk in hint)
          FitThereTextField(
            controller: _emailController,
            hintText: 'Email address',
            isRequired: true,
            validator: FieldValidators.emailValidator,
            type: FitThereTextFieldType.email,
          ),
          
          const SizedBox(height: 16),
          
          // Optional field
          FitThereTextField(
            controller: _phoneController,
            labelText: 'Phone number (optional)',
            hintText: 'Enter your phone number',
            isRequired: false,
            type: FitThereTextFieldType.number,
          ),
        ],
      ),
    );
  }
}
```

## Styling

The red asterisk uses the `AppColors.error` color and inherits the font weight from the label or hint text style. The asterisk is positioned with a small gap (4px) from the text.

## Best Practices

1. **Use labels for required fields** - This provides the clearest indication of required fields
2. **Be consistent** - Use the same approach throughout your app
3. **Combine with validation** - Always use validators with required fields
4. **Consider accessibility** - The visual asterisk helps users identify required fields quickly

## Migration

If you have existing `FitThereTextField` widgets, you can add the `isRequired: true` parameter to any field that should be marked as required. This is a non-breaking change. 