from rest_framework import serializers
from .models import BlogPost, Users
#from django.contrib.auth.hashers import make_password
from django.contrib.auth.models import User  # Import the default User model

class BlogPostSerializer(serializers.ModelSerializer):
    class Meta:
        model = BlogPost
        fields = '__all__'

# class UserSerializer(serializers.ModelSerializer):
#     class Meta:
#         model = Users
#         fields = ['id', 'username', 'email', 'password']
#         extra_kwargs = {'password': {'write_only': True}}

#     def create(self, validated_data):
#         user = Users.objects.create(
#             username=validated_data['username'],
#             email=validated_data['email'],
#             password=make_password(validated_data['password'])  # Hash the password
#         )
#         return user


class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User  # Use the default User model
        fields = ['id', 'username', 'email', 'password']
        extra_kwargs = {'password': {'write_only': True}}

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']  # Password is automatically hashed by `create_user`
        )
        return user