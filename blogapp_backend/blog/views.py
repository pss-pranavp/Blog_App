from rest_framework import generics, permissions, status
from .models import BlogPost
from .serializers import BlogPostSerializer, UserSerializer
from rest_framework.views import APIView
from rest_framework.response import Response
from django.views.decorators.csrf import csrf_exempt
from django.utils.decorators import method_decorator
from .models import Users
from django.contrib.auth.hashers import check_password
from rest_framework.authtoken.models import Token
from rest_framework.authtoken.views import ObtainAuthToken
from django.contrib.auth.hashers import check_password, make_password
from django.contrib.auth import authenticate
import logging
#from django.contrib.auth.models.User  # Import the default User model
from django.contrib.auth.models import User 

@method_decorator(csrf_exempt, name='dispatch')
class BlogPostListCreate(generics.ListCreateAPIView):
    queryset = BlogPost.objects.all()
    serializer_class = BlogPostSerializer
    #permission_classes = [permissions.IsAuthenticatedOrReadOnly]

@method_decorator(csrf_exempt, name='dispatch')
class BlogPostRetrieveUpdateDestroy(generics.RetrieveUpdateDestroyAPIView):
    queryset = BlogPost.objects.all()
    serializer_class = BlogPostSerializer
    #permission_classes = [permissions.IsAuthenticatedOrReadOnly]


class BlogPostListAPIView(APIView):
    def get(self, request, *args, **kwargs):
        blogposts = BlogPost.objects.all()
        serializer = BlogPostSerializer(blogposts, many=True)
        return Response(serializer.data)


class RegisterView(APIView):
    def post(self, request):
        serializer = UserSerializer(data=request.data)
        if serializer.is_valid():
            serializer.save()
            return Response(serializer.data, status=status.HTTP_201_CREATED)
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

class LoginView(APIView):
    def post(self, request):
        username = request.data.get("username")
        password = request.data.get("password")

        user = authenticate(username=username, password=password)
        if user is not None:
            token, created = Token.objects.get_or_create(user=user)
            return Response({"token": token.key}, status=status.HTTP_200_OK)
        else:
            return Response({"error": "Invalid credentials"}, status=status.HTTP_400_BAD_REQUEST)

# working with the login my and regi def
# class RegisterView(APIView):
#     def post(self, request, *args, **kwargs):
#         serializer = UserSerializer(data=request.data)
#         if serializer.is_valid():
#             serializer.save()
#             return Response(serializer.data, status=status.HTTP_201_CREATED)
#         return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

# logger = logging.getLogger(__name__)

# class LoginView(APIView):

#     def post(self, request, *args, **kwargs):
#         username = request.data.get("username")
#         password = request.data.get("password")
        
#         # Log the incoming credentials for debugging (in production, avoid logging passwords)
#         logger.info(f"Attempting login with username: {username}")
        
#         user = authenticate(username=username, password=password)

#         if user is not None:
#             token, created = Token.objects.get_or_create(user=user)
#             return Response({"token": token.key}, status=status.HTTP_200_OK)
#         else:
#             logger.warning(f"Login failed for username: {username}")
#             return Response({"error": "Invalid credentials"}, status=status.HTTP_400_BAD_REQUEST)



# second time
# class LoginView(ObtainAuthToken):
#     def post(self, request, *args, **kwargs):
#         print("Request Data: ", request.data)
#         username = request.data.get('username')
#         password = request.data.get('password')

#         if not username or not password:
#             return Response({"error": "Username and password are required"}, status=status.HTTP_400_BAD_REQUEST)

#         try:
#             user = Users.objects.get(username=username)
#             if check_password(password, user.password):
#                 token, created = Token.objects.get_or_create(user=user)
#                 return Response({"token": token.key})
#             else:
#                 return Response({"error": "Invalid credentials"}, status=status.HTTP_400_BAD_REQUEST)
#         except Users.DoesNotExist:
#             return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)



# first time
# class LoginView(APIView):
#     def post(self, request, *args, **kwargs):
#         username = request.data.get('username')
#         password = request.data.get('password')
#         try:
#             user = Users.objects.get(username=username)
#             if check_password(password, user.password):
#                 return Response({"message": "Login successful"}, status=status.HTTP_200_OK)
#             else:
#                 return Response({"error": "Invalid credentials"}, status=status.HTTP_400_BAD_REQUEST)
#         except Users.DoesNotExist:
#             return Response({"error": "User not found"}, status=status.HTTP_404_NOT_FOUND)        